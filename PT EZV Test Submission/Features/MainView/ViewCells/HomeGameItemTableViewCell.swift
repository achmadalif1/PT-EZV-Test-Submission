//
//  HomeGameItemTableViewCell.swift
//  RAWGame
//
//  Created by Ahmad Nur Alifulloh on 20/07/22.
//

import UIKit

class HomeGameItemTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
