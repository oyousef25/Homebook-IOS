//
//  DetailsViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-10.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
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

        /*
            Populate the outlets with the proper values
         */
        listingAddress.text = "\(listing.streetNumber ?? "") \(listing.streetName ?? "")"
        listingLocation.text = "\(listing.city ?? ""), \(listing.stateOrProvince ?? ""), \(listing.country ?? "")"
        listingDetails.text = "\(listing.bedroomsTotal ?? 0) bed | \(listing.bathroomsTotalInteger ?? 0) bath"
        
        /*
            Format our price integer
         */
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        //Using the formatter to turn our Int to a currency
        listingPrice.text = formatter.string(from: NSNumber(value: listing.listPrice ?? 0))
        
        listingType.text = listing.propertySubType
        listingSqft.text = "\(String(listing.livingArea ?? 0)) Sqft"
        listingYear.text = String(listing.yearBuilt ?? 0)
        listingMls.text = listing.listAgentMlsId
        listingDate.text = listing.onMarketDate
    }
    

}
