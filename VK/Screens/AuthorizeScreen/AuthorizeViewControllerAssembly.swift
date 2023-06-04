//
//  AuthorizeViewControllerAssembly.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation
import UIKit

protocol IAuthorizeViewControllerAssembly {
	func assembly(navigationController: UINavigationController) -> UIViewController
}

final class AuthorizeViewControllerAssembly: IAuthorizeViewControllerAssembly {
	private let tokenStorage: IMutableTokenStorage
	private let tabBarControllerAssembly: ITabBarControllerAssembly

	init(
		tokenStorage: IMutableTokenStorage,
		tabBarControllerAssembly: ITabBarControllerAssembly
	) {
		self.tokenStorage = tokenStorage
		self.tabBarControllerAssembly = tabBarControllerAssembly
	}

	func assembly(navigationController: UINavigationController) -> UIViewController {
		let router = AuthorizeRouter(tabBarControllerAssembly: tabBarControllerAssembly)
		router.navigationController = navigationController

		let presenter = AuthorizePresenter(router: router, tokenStorage: tokenStorage)

		let authorizeView = VKAuthorizeView()
		authorizeView.delegate = presenter

		let viewController = AuthorizeViewController(presenter: presenter, authorizeView: authorizeView)
		return viewController
	}
}
