//
//  SavedListingTableViewCell.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-17.
//

import UIKit

class SavedListingTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var listingImage: UIImageView!
    @IBOutlet weak var listingPrice: UILabel!
    @IBOutlet weak var listingDetails: UILabel!
    @IBOutlet weak var listingAddress: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: SetUpCell Method
    func setUpCell(listing: ListingsList){
        /*
            Format our price integer
         */
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        /*
         Populating our views with data from the listing object
         */
        listingPrice.text = formatter.string(from: NSNumber(value: listing.listPrice))
        
        listingDetails.text = "\(listing.bedroomsTotal ) bed | \(listing.bathroomsTotalInteger) bath"
            
        listingAddress.text = "\(listing.streetNumber ?? "") \(listing.streetName ?? ""), \(listing.city ?? ""), \(listing.stateOrProvince ?? ""), \(listing.country ?? "")"


        //TODO: Pass the listing image
        //get the poster path string
        guard let posterPath = listing.mediaURL else { return }

        //build a url to fetch the album and load the image
        if let url = buildImageUrl(for: posterPath){
            print(url)
            loadPoster(url: url, forCell: self)
        }
    }
    
    //MARK: Image Loading Methods
    
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
    func loadPoster(url: URL, forCell cell: SavedListingTableViewCell){
        /*
         Starting a new URL session to read the image from the url
         */
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url){
            url, response, error in
            
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let posterImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.listingImage.image = posterImage
                }
            }
        }
        task.resume()
    }
}
