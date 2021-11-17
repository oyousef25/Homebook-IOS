//
//  FilterViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-10.
//

import UIKit

class FilterViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var minPrice: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    @IBOutlet weak var minBeds: UITextField!
    @IBOutlet weak var maxBeds: UITextField!
    @IBOutlet weak var minBaths: UITextField!
    @IBOutlet weak var maxBaths: UITextField!
    
    
    //MARK: Properties
    var listings = [Listing]()
    var filteredListings = [Listing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /*
        MARK: Filtering methods
     */
    //This method will take the vlaue of our 6 outlets
    func applyFilter(listings: [Listing]){
        //listings.filter()
        
        
    }
//    func applyFilter(minPrice: (Int) -> Bool, maxPrice: (Int) -> Bool, minBeds: (Int) -> Bool, maxBeds: (Int) -> Bool, minBaths: (Int) -> Bool, maxBaths: (Int) -> Bool){
//
//
//
//    }

    @IBAction func applyTapped(_ sender: Any) {
//        let ac = UIAlertController(title: "Success!", message: "Filter operation applied successfully!", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
//        present(ac, animated: true)
        
        navigationController?.popViewController(animated: true)
    }
}
