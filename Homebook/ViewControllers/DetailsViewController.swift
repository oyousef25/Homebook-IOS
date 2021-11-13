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
        let formatter = NumberFormatter()
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
        
        let listingAddress = "\(String(describing: listing.streetNumber))\(listing.streetName ?? "")"
        
        //Creating our pin
        let pin = LocationPin(title: listing.listPrice ?? 0, subTitle: listingAddress, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))

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
        let identifier = "listing"
        
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
}
