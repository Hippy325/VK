//
//  TabBarControllerAssembly.swift
//  VK
//
//  Created by User on 10.05.2023.
//

import Foundation
import UIKit

protocol ITabBarControllerAssembly {
	func assembly() -> UITabBarController
}

protocol IChaildNavigationControllerAssembly {
	func assembly() -> UINavigationController
}

final class TabBarControllerAssembly: ITabBarControllerAssembly {

	private let navigationControllerAssemlyes: [IChaildNavigationControllerAssembly]

	init(navigationControllerAssemlyes: [IChaildNavigationControllerAssembly]) {
		self.navigationControllerAssemlyes = navigationControllerAssemlyes
	}

	func assembly() -> UITabBarController {
		let tabBarController = UITabBarController()

		tabBarController.setViewControllers(navigationControllerAssemlyes.map({ $0.assembly() }), animated: true)
		tabBarController.tabBar.barTintColor = .darkGrayBack
		return tabBarController
	}
}
