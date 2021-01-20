//
//  TabBarRouter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol TabBarRouterable {
	static func assembly() -> UITabBarController
}

class TabBarRouter {
	private weak var controller: UITabBarController?
}

extension TabBarRouter: TabBarRouterable {
	static func assembly() -> UITabBarController {
		let router = TabBarRouter()

		let searchAlbumsVC = configureVC(rootVC: SearchAlbumsSceneRouter.assembly(), imageName: Constants.searchSceneItemData.imageName, title: Constants.searchSceneItemData.title)
		let storedAlbumsVC = configureVC(rootVC: StoredAlbumsSceneRouter.assembly(), imageName: Constants.storedSceneItemData.imageName, title: Constants.storedSceneItemData.title)
		let locationVC = configureVC(rootVC: LocationSceneRouter.assembly(), imageName: Constants.locationSceneItemData.imageName, title: Constants.locationSceneItemData.title)
		
		let tabBarController	= UITabBarController()
		
		router.controller = tabBarController
		router.controller?.viewControllers = [searchAlbumsVC, storedAlbumsVC, locationVC]
		
		guard let controller = router.controller else {
			fatalError("cannot instantiate \(String(describing: UITabBarController.self))")
		}
		
		return controller
	}
	
	private static func configureVC(rootVC: UIViewController, imageName: String, title: String) -> UIViewController {
		let navigationVC = UINavigationController(rootViewController: rootVC)
		navigationVC.tabBarItem.image = UIImage(named: imageName)
		navigationVC.tabBarItem.title = title
		rootVC.navigationItem.title = title
		navigationVC.navigationBar.prefersLargeTitles = true
		
		return navigationVC
	}
}

extension TabBarRouter {
	private struct Constants {
		static let searchSceneItemData = (title: "Search albums", imageName: "SearchAlbumsItemImage-universal")
		static let storedSceneItemData = (title: "Stored albums", imageName: "StoredAlbumsItemImage-universal")
		static let locationSceneItemData = (title: "Location", imageName: "LocationItemImage-universal")
	}
}
