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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        listingImageview.image = UIImage(systemName: "1.square.fill")
        detailsLabel.text = "\(listing.bedroomsTotal ?? 0) bed | \(listing.bathroomsTotalInteger ?? 0) bath"
            
            
        locationLabel.text = "\(listing.streetNumber ?? "") \(listing.streetName ?? ""), \(listing.city ?? ""), \(listing.stateOrProvince ?? ""), \(listing.country ?? "")"
    }
}
