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
    func setUpCell(){
        //populate the cell values
        listingImageview.image = UIImage(systemName: "1.square.fill")
        PriceLabel.text = "$100.00"
        detailsLabel.text = "3beds | 2baths"
        locationLabel.text = "1040 Lemonwood Crescent, Windsor, ON"
    }
}
