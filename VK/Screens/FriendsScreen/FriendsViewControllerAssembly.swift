//
//  FriendsViewControllerAssembly.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation
import UIKit

protocol IFriendsViewControllerAssembly: AnyObject {
	func assembly(userId: Int?, navigationControler: UINavigationController) -> UIViewController
}

final class FriendsViewControllerAssembly: IFriendsViewControllerAssembly {
	private let profileViewControllerAssembly: IProfileViewControllerAssembly
	private let tokenStorage: ITokenStorage
	private let apiTransport: IAPITransport
	private let imageLoader: IImageLoader

	init(
		profileViewControllerAssembly: IProfileViewControllerAssembly,
		tokenStorage: ITokenStorage,
		apiTransport: IAPITransport,
		imageLoader: IImageLoader
	) {
		self.profileViewControllerAssembly = profileViewControllerAssembly
		self.tokenStorage = tokenStorage
		self.apiTransport = apiTransport
		self.imageLoader = imageLoader
	}

	func assembly(userId: Int?, navigationControler: UINavigationController) -> UIViewController {
		let router = FriendsRouter(profileViewControllerAssembly: profileViewControllerAssembly)
		router.navigationController = navigationControler

		let presenter = FriendsPresenter(
			router: router,
			tokenStorage: tokenStorage,
			apiTransport: apiTransport,
			imageLoader: imageLoader,
			userId: userId
		)

		let viewController = FriendsViewController(presenter: presenter)
		presenter.view = viewController

		return viewController
	}
}
