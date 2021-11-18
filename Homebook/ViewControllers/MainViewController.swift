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
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Properties
    var listings = [Listing]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        tableView.dataSource = self
        
        //Create an API URL using the user's input
        let url = createListingURL(for: "Florida")
        
        if let apiUrl = url{
            //Fetch listings form the API
            fetchListings(from: apiUrl)
            
            //Reload the tableview to show the new data
            tableView.reloadData()
            
        }else{
            print("Could not read from API")
        }
    }
    
    
    //MARK: API Methods
    /*
        Function to create a valid URL
     */
    func createListingURL(for state: String) -> URL?{
        //Create the url string and return it
        guard let cleanURL = state.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { fatalError("Can't create a valid url") }
                
        let apiKey = "5d66582838c6c0b8c9674f61ff2f5453"
        
        var urlString = "https://api.bridgedataoutput.com/api/v2/OData/test/Properties?"
        urlString = urlString.appending("access_token=\(apiKey)&")
        urlString = urlString.appending(#"$"# + "filter=contains(StateOrProvince,%27\(cleanURL)%27)&$top=20")
        print(urlString)
        
        return URL(string: urlString)
    }
    
    
    /*
        Fetch the albums from the API
     */
    func fetchListings(from url: URL){
        //Starting a new url session to fetch data from the JSON object thats returned by our URL
        let listingTask = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            //Handling any errors and diplaying them
            if let error = error {
                print("There was an error fetching the data - \(error.localizedDescription)")
            } else {
                do {
                    //Unwrapping using optional binding to make sure its not nil
                    guard let someData = data else { return }
                    
                    /*
                        Decoding the JSON data
                     */
                    let jsonDecoder = JSONDecoder()
                    let downloadedResults = try jsonDecoder.decode(Listings.self, from: someData)
                    
                    //Adding all the results to our albums array
                    self.listings = downloadedResults.value
                    print("listings: \(self.listings.count)")
                    
                } catch let error {
                    print("Problem decoding: \(error)")
                }
                
                //Reloading the tableview to display the new results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        listingTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //this will have the information about which cell we are navigating to
        guard let destinationVC = segue.destination as? DetailsViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        
        //Passing the selected business object to the details controller
        destinationVC.listing = listings[indexPath.row]
    }
}

//MARK: TableView DataSource Methods
extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creating a new instance of our cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! ListingTableViewCell
        
        let listing = listings[indexPath.row]
        
        //Setting up our cell with the values passed by the API
        cell.setUpCell(listing: listing)
        
        //Returning our populated cell
        return cell
    }
}

extension MainViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Storing the value of the user input in a variable to access it later when creating the url
        if let text = searchBar.text, !text.isEmpty {
            print("Searching for \(text)")
            
            //creating a new url using the user input in the search bar
            if let url = createListingURL(for: text){
            
                //Fetching the albums from the url
                fetchListings(from: url)
            }
        } else {
            print("Nothing entered")
        }
        
        searchBar.resignFirstResponder()
    }
}

