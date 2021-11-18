//
//  SavedListingsDetailsViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-17.
//

import UIKit
import MapKit

class SavedListingsDetailsViewController: UIViewController {
    /*
        MARK: Properties
     */
    var listing: ListingsList!
    let formatter = NumberFormatter()
    
    //MARK: Outlets
    @IBOutlet weak var listingImage: UIImageView!
    @IBOutlet weak var listingAddress: UILabel!
    @IBOutlet weak var listingLocation: UILabel!
    @IBOutlet weak var listingDetails: UILabel!
    @IBOutlet weak var listingPrice: UILabel!
    @IBOutlet weak var propertyType: UILabel!
    @IBOutlet weak var listingSqft: UILabel!
    @IBOutlet weak var listingYearBuilt: UILabel!
    @IBOutlet weak var listingMlsId: UILabel!
    @IBOutlet weak var listingDate: UILabel!
    @IBOutlet weak var listingMapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //A fortmatter that we are going to use later to format our listing price
        formatter.numberStyle = .currency

        /*
         MARK: Populate the items with the listing data passed form the savedListings controller
         */
        /*
            Main listing information
         */
        listingAddress.text = "\(listing.streetNumber ?? "") \(listing.streetName ?? "")"
        
        listingLocation.text = "\(listing.city ?? ""), \(listing.stateOrProvince ?? ""), \(listing.country ?? "")"
        
        listingDetails.text = "\(listing.bedroomsTotal) bed  |  \(listing.bathroomsTotalInteger) bath"
        
        listingPrice.text = formatter.string(from: NSNumber(value: listing.listPrice))
        
        /*
            Extra listing details details
         */
        propertyType.text = listing.propertySubType
        listingSqft.text = "\(String(listing.livingArea)) Sqft"
        listingYearBuilt.text = String(listing.yearBuilt)
        listingMlsId.text = listing.listAgentMlsId
        listingDate.text = listing.onMarketDate
        
        //Placing the pin on the map
        centerOnPin()
        
        //Loading the image using the image loading methods
        //get the image path string
        guard let imagePath = listing.mediaURL else { return }
        
        //build a url to fetch the listing image
        if let url = buildImageUrl(for: imagePath){
            print(url)
            loadPoster(url: url, forView: listingImage)
        }
    }
    
    /*
        MARK: Mapview methods
     */
    /*
        centerOnPin()
        This method will be used to place the pin on our mapview using the listing coordinates
     */
    func centerOnPin(){
        //Unwrapping our values
        guard let listing = listing else{ return }
                
        //Storing our coordinates to use them later to place the pin
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: listing.latitude, longitude: listing.longitude), latitudinalMeters: 10_000, longitudinalMeters: 10_000)
        
        //Setting the region on the map using our coordinates
        listingMapview.setRegion(coordinateRegion, animated: true)
        
        let listingAddress = "\(listing.streetNumber ?? "") \(listing.streetName ?? "")"
        
        formatter.numberStyle = .currency
        let price = formatter.string(from: NSNumber(value: listing.listPrice)) ?? ""
        
        //Creating our pin
        let pin = LocationPin(title: price, subTitle: listingAddress, coordinate: CLLocationCoordinate2D(latitude: listing.latitude, longitude: listing.longitude))

        //Adding our pin to the mapview
        listingMapview.addAnnotation(pin)
    }
    
    /*
        MARK: Image Loading Methods
     */
    /*
     buildImageUrl()
     This method will turn the image's string into a url to use later for image displaying
     */
    func buildImageUrl(for path: String) -> URL? {
        let imagePath = path
        
        guard let imageURL = URL(string: imagePath) else { return nil}

        return imageURL
    }
    
    /*
     loadImage()
     */
    func loadPoster(url: URL, forView imageview: UIImageView){
        /*
         Starting a new URL session to read the image from the url
         */
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url){
            url, response, error in
            
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let posterImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageview.image = posterImage
                }
            }
        }
        task.resume()
    }
}
