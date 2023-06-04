//
//  NavigationControllerAssembly.swift
//  VK
//
//  Created by User on 26.04.2023.
//

import Foundation
import UIKit

protocol INavigationControllerAssembly {
	func assembly() -> UINavigationController
}

final class NavigationControllerAssembly: INavigationControllerAssembly {
	func assembly() -> UINavigationController {
		let navigationController = UINavigationController()
		navigationController.navigationBar.barTintColor = .systemGray
		setupNavigationBar(navigationController: navigationController)
		return navigationController
	}

	private func setupNavigationBar(navigationController: UINavigationController) {
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .darkGrayBack
		appearance.shadowColor = .clear
		navigationController.navigationBar.standardAppearance = appearance.copy()
		navigationController.navigationBar.scrollEdgeAppearance = appearance.copy()
	}
}
