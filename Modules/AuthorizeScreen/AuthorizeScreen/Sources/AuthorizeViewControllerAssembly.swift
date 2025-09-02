//
//  AuthorizeViewControllerAssembly.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation
import UIKit
import Storage
import Services
import Navigation

@MainActor
public protocol IAuthorizeViewControllerAssembly: Sendable {
	func assembly(navigationController: UINavigationController) -> UIViewController
}

public final class AuthorizeViewControllerAssembly: IAuthorizeViewControllerAssembly {
	private let tokenStorage: IMutableTokenStorage
	private let tabBarControllerAssembly: ITabBarControllerAssembly

	public init(
		tokenStorage: IMutableTokenStorage,
		tabBarControllerAssembly: ITabBarControllerAssembly
	) {
		self.tokenStorage = tokenStorage
		self.tabBarControllerAssembly = tabBarControllerAssembly
	}

	public func assembly(navigationController: UINavigationController) -> UIViewController {
		let router = AuthorizeRouter(tabBarControllerAssembly: tabBarControllerAssembly)
		router.navigationController = navigationController

		let presenter = AuthorizePresenter(router: router, tokenStorage: tokenStorage)

		let authorizeView = VKAuthorizeView()
		authorizeView.delegate = presenter

		let viewController = AuthorizeViewController(presenter: presenter, authorizeView: authorizeView)
		return viewController
	}
}
