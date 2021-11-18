//
//  ListingTableViewCell.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-10-27.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var listingImageview: UIImageView!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Methods
    func setUpCell(listing: Listing){
        /*
            Format our price integer
         */
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        /*
         Populating our views with data from the listing object
         */
        PriceLabel.text = formatter.string(from: NSNumber(value: listing.listPrice ?? 0))
        detailsLabel.text = "\(listing.bedroomsTotal ?? 0) bed | \(listing.bathroomsTotalInteger ?? 0) bath"
            
            
        locationLabel.text = "\(listing.streetNumber ?? "") \(listing.streetName ?? ""), \(listing.city ?? ""), \(listing.stateOrProvince ?? ""), \(listing.country ?? "")"
        
        
        //get the poster path string
        guard let posterPath = listing.media?[0].mediaURL else { return }
        
        //build a url to fetch the album and load the image
        if let url = buildImageUrl(for: posterPath){
            print(url)
            loadPoster(url: url, forCell: self)
        }
    }
    
    
    /*
        MARK: Loading listing image methods
     */
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
    func loadPoster(url: URL, forCell cell: ListingTableViewCell){
        /*
         Starting a new URL session to read the image from the url
         */
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url){
            url, response, error in
            
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let posterImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.listingImageview.image = posterImage
                }
            }
        }
        task.resume()
    }
}
