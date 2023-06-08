//
//  TabBarControllerAssembly.swift
//  VK
//
//  Created by User on 10.05.2023.
//

import Foundation
import Utilities
import UIKit

public protocol ITabBarControllerAssembly {
	func assembly() -> UITabBarController
}

public protocol IChaildNavigationControllerAssembly {
	func assembly() -> UINavigationController
}

public final class TabBarControllerAssembly: ITabBarControllerAssembly {

	private let navigationControllerAssemlyes: [IChaildNavigationControllerAssembly]

	public init(navigationControllerAssemlyes: [IChaildNavigationControllerAssembly]) {
		self.navigationControllerAssemlyes = navigationControllerAssemlyes
	}

	public func assembly() -> UITabBarController {
		let tabBarController = UITabBarController()

		tabBarController.setViewControllers(navigationControllerAssemlyes.map({ $0.assembly() }), animated: true)
		tabBarController.tabBar.barTintColor = .darkGrayBack
		return tabBarController
	}
}
