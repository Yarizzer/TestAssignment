//
//  AppRouter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol AppRouterable {
	func routeToInitialScene()
}

class AppRouter {
	init(withWindow window: UIWindow) {
		self.window = window
	}
	
	private var window: UIWindow
}

extension AppRouter: AppRouterable {
	func routeToInitialScene() {
		window.rootViewController = TabBarRouter.assembly()
		window.makeKeyAndVisible()
	}
}
