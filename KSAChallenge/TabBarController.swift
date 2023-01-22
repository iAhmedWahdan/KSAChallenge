//
//  TabBarController.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .orange
        tabBar.backgroundImage = UIImage.init()
    }
    
    private func setupViewControllers() {
        let usersViewController = AppNavigationController(rootViewController: UsersViewController())
        usersViewController.tabBarItem.title = "Users"
        usersViewController.tabBarItem.image = UIImage(systemName: "person.2.fill")
        
        viewControllers = [
            usersViewController
        ]
    }
}
