//
//  DetailsViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-10.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    /*
        MARK: Properties
     */
    var listing: Listing!
    let formatter = NumberFormatter()
    
    /*
        MARK: Outlets
    */
    @IBOutlet weak var listingImage: UIImageView!
    @IBOutlet weak var listingAddress: UILabel!
    @IBOutlet weak var listingLocation: UILabel!
    @IBOutlet weak var listingDetails: UILabel!
    @IBOutlet weak var listingPrice: UILabel!
    
    @IBOutlet weak var listingType: UILabel!
    @IBOutlet weak var listingSqft: UILabel!
    @IBOutlet weak var listingYear: UILabel!
    @IBOutlet weak var listingMls: UILabel!
    @IBOutlet weak var listingDate: UILabel!
    
    @IBOutlet weak var listingMapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //A fortmatter that we are going to use later to format our listing price
        formatter.numberStyle = .currency

        /*
            MARK: Populate the outlets with the proper values
         */
        /*
            Main listing information
         */
        listingAddress.text = "\(listing.streetNumber ?? "") \(listing.streetName ?? "")"
        
        listingLocation.text = "\(listing.city ?? ""), \(listing.stateOrProvince ?? ""), \(listing.country ?? "")"
        
        listingDetails.text = "\(listing.bedroomsTotal ?? 0) bed | \(listing.bathroomsTotalInteger ?? 0) bath"
        
        listingPrice.text = formatter.string(from: NSNumber(value: listing.listPrice ?? 0))
        
        /*
            Extra listing details details
         */
        listingType.text = listing.propertySubType
        listingSqft.text = "\(String(listing.livingArea ?? 0)) Sqft"
        listingYear.text = String(listing.yearBuilt ?? 0)
        listingMls.text = listing.listAgentMlsId
        listingDate.text = listing.onMarketDate
        
        /*
            MARK: Placing a pin on our mapview
         */
        //Setting the delegate for our mapview for styling
        listingMapview.delegate = self
        
        //Styling our mapview
        listingMapview.layer.cornerRadius = 15
        listingMapview.isScrollEnabled = false
        listingMapview.isZoomEnabled = false
        
        //Calling our method to place the pin on the map
        centerOnPin()
        
        //Load our listing image from the API
        //TODO: Pass the listing image
        //get the poster path string
        //guard let posterPath = listing.media else { return }
        
        //Default image
        let posterPath = "https://s3.amazonaws.com/retsly-importd-production/test_data/listings/18.jpg"
        
        //build a url to fetch the album and load the image
        if let url = buildImageUrl(for: posterPath){
            print(url)
            loadPoster(url: url, forView: listingImage)
        }
    }
    
    //MARK: Mapview method
    /*
        centerOnPin()
        This method will be used to place the pin on our mapview using the listing coordinates
     */
    func centerOnPin(){
        //Unwrapping our values
        guard let listing = listing else{ return }
        guard let latitude = listing.latitude, let longitude = listing.longitude else { return }
                
        //Storing our coordinates to use them later to place the pin
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 10_000, longitudinalMeters: 10_000)
        
        //Setting the region on the map using our coordinates
        listingMapview.setRegion(coordinateRegion, animated: true)
        
        let listingAddress = "\(listing.streetNumber ?? "") \(listing.streetName ?? "")"
        
        formatter.numberStyle = .currency
        let price = formatter.string(from: NSNumber(value: listing.listPrice ?? 0)) ?? ""
        
        //Creating our pin
        let pin = LocationPin(title: price, subTitle: listingAddress, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))

        //Adding our pin to the mapview
        listingMapview.addAnnotation(pin)
    }
    
    /*
        MARK: MApview delegate method
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //Checking if our annotation is a locationPin otherwise end task
        guard annotation is LocationPin else{return nil}
        
        //Storing our identifier
        let identifier = "Listing"
        
        //Creating our view
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        //show the view if the its not showing
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
            annotationView?.canShowCallout = true
            
        }else{
            //Show the annotation
            annotationView?.annotation = annotation
        }
        
        //returning our view
        return annotationView
    }
    
    /*
        MARK: Loading listing image methods
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
