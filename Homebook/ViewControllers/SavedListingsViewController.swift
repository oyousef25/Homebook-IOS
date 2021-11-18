//
//  SavedListingsViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-10-27.
//

import UIKit
import CoreData

class SavedListingsViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    /*
        MARK: Properties
     */
    var savedListings = [ListingsList]()
    
    //We will be using this core data stack to load our listing items
    lazy var coreDataStack = CoreDataStack(modelName: "Homebook")

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Load our data
        fetchSavedListings()
        
        //Reloading our tableview
        tableview.reloadData()
    }
    
    /*
        MARK: Core Data Method
     */
    func fetchSavedListings(){
        //Fetch data
        let fetchRequest: NSFetchRequest<ListingsList> = ListingsList.fetchRequest()
        
        do {
            //Fetching the contacts and assigning them to our savedListings
            savedListings = try coreDataStack.managedContext.fetch(fetchRequest)
        } catch {
            print("There was an error fetching the taskLists: \(error.localizedDescription)")
        }
        
    }
    
}

//MARK: TableView DataSource Methods
extension SavedListingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Creating a new instance of our cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedListingTableViewCell

        let listing = savedListings[indexPath.row]

        //Setting up our cell with the values passed by the API
        cell.setUpCell(listing: listing)

        //Returning our populated cell
        return cell
    }
}
