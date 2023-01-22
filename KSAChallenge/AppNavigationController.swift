//
//  AppNavigationController.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationBar.prefersLargeTitles = true
        
        let titleTextAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        
        let largeTitleTextAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont.boldSystemFont(ofSize: 25)
        ]
        navigationBar.tintColor = .orange
        
        let standardAppearance = navigationBar.standardAppearance
        let scrollEdgeAppearance = navigationBar.scrollEdgeAppearance ?? UINavigationBarAppearance()
        
        standardAppearance.titleTextAttributes = titleTextAttributes
        standardAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        standardAppearance.backgroundColor = .black
        standardAppearance.shadowColor = .clear
        
        scrollEdgeAppearance.titleTextAttributes = titleTextAttributes
        scrollEdgeAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        scrollEdgeAppearance.backgroundColor = .black
        scrollEdgeAppearance.shadowColor = .clear
        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}
