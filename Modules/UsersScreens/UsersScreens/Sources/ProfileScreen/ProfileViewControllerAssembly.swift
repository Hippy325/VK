//
//  ProfileViewControllerAssembly.swift
//  VK
//
//  Created by User on 04.05.2023.
//

import Foundation
import UIKit
import Storage
import Services

public protocol IProfileViewControllerAssembly: AnyObject {
	var friendsViewControllerAssembly: IFriendsViewControllerAssembly? { get set }
	func assembly(userId: Int?, navigationControler: UINavigationController?) -> UIViewController
}

public final class ProfileViewControllerAssembly: IProfileViewControllerAssembly {

	private let apiTransport: IAPITransport
	private var imageLoader: IImageLoader
	private let tokenStorage: ITokenStorage
	public weak var friendsViewControllerAssembly: IFriendsViewControllerAssembly?

	public init(
		apiTransport: IAPITransport,
		imageLoader: IImageLoader,
		tokenStorage: ITokenStorage
	) {
		self.apiTransport = apiTransport
		self.imageLoader = imageLoader
		self.tokenStorage = tokenStorage
	}

	public func assembly(userId: Int?, navigationControler: UINavigationController?) -> UIViewController {
		let router = ProfileRouter()
		router.navigationController = navigationControler
		router.friendsViewControllerAssembly = friendsViewControllerAssembly

		let presenter = ProfilePresenter(
			apiTransport: apiTransport,
			imageLoader: imageLoader,
			tokenStorage: tokenStorage,
			router: router,
			userId: userId
		)

		let viewController = ProfileViewController(presenter: presenter)
		presenter.view = viewController

		return viewController
	}
}
