//
//  SavedListingsViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-10-27.
//

import UIKit

class SavedListingsViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    /*
        MARK: Properties
     */
    var savedListings = [Listing]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
    }
}

//MARK: TableView DataSource Methods
extension SavedListingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Creating a new instance of our cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedListingTableViewCell

        //let listing = savedListings[indexPath.row]

        //Setting up our cell with the values passed by the API
        //cell.setUpCell(listing: listing)

        //Returning our populated cell
        return cell
    }
}
