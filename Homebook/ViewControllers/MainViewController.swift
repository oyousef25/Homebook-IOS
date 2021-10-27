//
//  ViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-10-19.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var listing: Listing!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Methods

}

//MARK: TableView DataSource Methods
extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Creating a new instance of our cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! ListingTableViewCell
        
        //Setting up our cell with the values passed by the API
        cell.setUpCell()
        
        //Returning our populated cell
        return cell
    }
}

