//
//  SceneDelegate.swift
//  UICollectionView-Collapsible-Section-Demo
//
//  Created by Seb Vidal on 17/02/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties
    var window: UIWindow?
    
    // MARK: - UIWindowSceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let viewController = CollectionViewController()
        viewController.title = "Browse"
        viewController.navigationItem.largeTitleDisplayMode = .always
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
        viewController.navigationItem.searchController = UISearchController(searchResultsController: nil)
        viewController.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(systemName: "folder.fill"), tag: 0)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController]
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}
