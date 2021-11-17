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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
