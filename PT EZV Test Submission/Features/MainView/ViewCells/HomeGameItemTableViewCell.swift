//
//  HomeGameItemTableViewCell.swift
//  RAWGame
//
//  Created by Ahmad Nur Alifulloh on 20/07/22.
//

import UIKit

class HomeGameItemTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var contentViewCell: UIView!
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
        setUpView()
        animateSubviews()
    }
    func setUpView(){

        self.contentViewCell.layer.cornerRadius = 12
        self.contentViewCell.layer.borderColor = UIColor.gray.cgColor
        self.contentViewCell.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.contentViewCell.layer.shadowRadius = 3
        self.contentViewCell.layer.shadowOpacity = 0.1
        self.contentViewCell.layer.shadowOffset = .zero
        self.contentViewCell.layer.shadowColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    private func animateSubviews() {
        
        let animations = {
            self.contentView.subviews.forEach { view in
                view.alpha = 1
                view.transform = CGAffineTransform.identity
            }
            self.contentView.setNeedsLayout()
            self.contentView.layoutIfNeeded()
        }
        
        self.contentView.subviews.forEach { view in
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        self.contentView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: animations) { _ in
            self.contentView.isUserInteractionEnabled = true
        }
        
    }
}
