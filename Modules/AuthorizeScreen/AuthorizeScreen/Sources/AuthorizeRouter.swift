//
//  AuthorizeRouter.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation
import Navigation
import UIKit

@MainActor
protocol IAuthorizeRouter: Sendable {
	var navigationController: UINavigationController? { get set }
	func goToTabBarScreen()
	func presentAlertAuthorized()
}

final class AuthorizeRouter: IAuthorizeRouter {
	weak var navigationController: UINavigationController?

	private let tabBarControllerAssembly: ITabBarControllerAssembly

	init(tabBarControllerAssembly: ITabBarControllerAssembly) {
		self.tabBarControllerAssembly = tabBarControllerAssembly
	}

	func goToTabBarScreen() {
		navigationController?.pushViewController(tabBarControllerAssembly.assembly(), animated: true)
	}

	func presentAlertAuthorized() {
		let alert = UIAlertController(title: "Authorize success", message: nil, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
		navigationController?.present(alert, animated: true)
	}
}
