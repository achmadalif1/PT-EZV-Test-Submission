//
//  TabBarViewController.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import UIKit

class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    tabBar.tintColor = .black
    tabBar.unselectedItemTintColor = .lightGray
    
    let homeNavigationController = UINavigationController(rootViewController: MainViewController())
    homeNavigationController.title = "Explore"
    homeNavigationController.tabBarItem.image = UIImage(named: "tabSearchUnselected")
    homeNavigationController.tabBarItem.selectedImage = UIImage(named: "tabSearch")
    
    viewControllers = [
      homeNavigationController
    ]
  }
}
