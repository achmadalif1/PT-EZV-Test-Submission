//
//  MainViewController.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    lazy var activityIndicator: UIActivityIndicatorView = {
      let activityIndicator = UIActivityIndicatorView()
      activityIndicator.hidesWhenStopped = true
      activityIndicator.style = .large
      return activityIndicator
    }()
    @IBOutlet weak var listProductTableView: UITableView!
    
    var viewModel: MainViewModel!
    var dataResult : [Product]?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupActivityIndicator()
        configureObserveData()
        setUpGameItemTableView()
        self.viewModel.getProducts()
        
    }
    func configureObserveData(){
        viewModel.result.observe(on: self) { [weak self] dataObserve in
            guard let dataResult = dataObserve else { return }
            self?.dataResult = dataResult
            print( "datanya \(self?.dataResult ?? [])")
            DispatchQueue.main.async {
                self?.listProductTableView.reloadData()
            }
            
        }
        viewModel.errorMessage.observe(on: self) { [weak self] message in
            guard let message = message else { return }
            print( "ERROR \(message)")
        }
        viewModel.isLoading.observe(on: self) { [weak self] isLoading in
            if isLoading{
                self?.activityIndicator.startAnimating()
            }else{
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    private func setupActivityIndicator() {
      view.addSubview(activityIndicator)
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    
}
extension MainViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    private func setUpGameItemTableView(){
        let nibName = UINib(nibName: "HomeGameItemTableViewCell", bundle: nil)
        listProductTableView.register(nibName, forCellReuseIdentifier: "HomeGameItemTableViewCell")
        listProductTableView.delegate = self
        listProductTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeGameItemTableViewCell", for: indexPath) as! HomeGameItemTableViewCell
        guard let data = dataResult else{return cell}
        cell.titleLabel.text = data[indexPath.row].title
        cell.ratingLabel.text = "Rating: \(data[indexPath.row].rating ?? -1)/ 5.00"
        cell.descriptionLabel.text = data[indexPath.row].description
        cell.priceLabel.text = "Harga : $\(data[indexPath.row].price ?? -1)"
        guard let imageUrl = data[indexPath.row].thumbnail else{return cell}
        cell.thumbnailImageView.kf.setImage(with: URL(string: imageUrl))
        var found = false
        for id in UserPersistence.likeId{
            if data[indexPath.row].id == id{
                found = true
            }
        }
        if found{
            cell.likeButton.setImage(UIImage.init(named: "likeSelected"), for: .normal)
        }else { cell.likeButton.setImage(UIImage.init(named: "likeUnSelected"), for: .normal)}
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MainDetailViewController()
        guard let data = dataResult else{return}
        vc.data = data[indexPath.row]
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    
}
extension MainViewController: MainDetailViewControllerDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.listProductTableView.reloadData()
        }
    }
}
