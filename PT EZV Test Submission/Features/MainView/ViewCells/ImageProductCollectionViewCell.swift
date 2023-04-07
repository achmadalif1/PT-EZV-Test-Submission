//
//  ImageProductCollectionViewCell.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import UIKit

class ImageProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animateSubviews()
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
