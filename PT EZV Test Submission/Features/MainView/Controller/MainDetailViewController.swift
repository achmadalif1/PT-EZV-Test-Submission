//
//  MainDetailViewController.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import UIKit

protocol MainDetailViewControllerDelegate {
    func reloadData()
}

class MainDetailViewController: UIViewController {
    lazy var activityIndicator: UIActivityIndicatorView = {
      let activityIndicator = UIActivityIndicatorView()
      activityIndicator.hidesWhenStopped = true
      activityIndicator.style = .large
      return activityIndicator
    }()
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var likeButton: UIButton!
    var data: Product!
    var delegate: MainDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        activityIndicator.startAnimating()
        configureUI()
        setUpCategoryItemCollectionView()
        setUpLikeView()
        activityIndicator.stopAnimating()
        
        
    }
    func setUpLikeView(){
        for id in UserPersistence.likeId{
            if data.id == id{
                likeButton.setImage(UIImage.init(named: "likeSelected"), for: .normal)
            }
        }
    }
    @IBAction func likeButtonAction(_ sender: Any) {
        var found = false
        for id in UserPersistence.likeId{
            if data.id == id{
                found = true
            }
        }
        if found{
            likeButton.setImage(UIImage.init(named: "likeUnSelected"), for: .normal)
            if let index = UserPersistence.likeId.firstIndex(of: data.id!) {
                UserPersistence.likeId.remove(at: index)
            }
            self.delegate?.reloadData()
            
        }else{
            likeButton.setImage(UIImage.init(named: "likeSelected"), for: .normal)
            guard let id = data.id else {return}
            UserPersistence.likeId.append(id)
            self.delegate?.reloadData()
        }
    }
    func configureUI(){
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
        self.priceLabel.text = "Harga : $\(data.price ?? -1)"
        guard let imageUrl = data.thumbnail else{return}
        self.thumbnailImageView.kf.setImage(with: URL(string: imageUrl))
    }
    private func setupActivityIndicator() {
      view.addSubview(activityIndicator)
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension MainDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    private func setUpCategoryItemCollectionView(){
        let nibName = UINib(nibName: "ImageProductCollectionViewCell", bundle: nil)
        imageCollectionView.register(nibName, forCellWithReuseIdentifier: "ImageProductCollectionViewCell")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageProductCollectionViewCell", for: indexPath) as! ImageProductCollectionViewCell
        guard let imageUrl = data.images?[indexPath.row] else{return cell}
        cell.imageView.kf.setImage(with: URL(string: imageUrl))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let sixColumnsCellWidth = (width - 60) / 14
     
        
        if (collectionView == imageCollectionView) { return CGSize(width: (sixColumnsCellWidth + 38) * 2, height: (sixColumnsCellWidth + 38) * 2)}
        
        return CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
