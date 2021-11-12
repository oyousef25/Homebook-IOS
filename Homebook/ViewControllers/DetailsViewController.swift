//
//  DetailsViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-10.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
