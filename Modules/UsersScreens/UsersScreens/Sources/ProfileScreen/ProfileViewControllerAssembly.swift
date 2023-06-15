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

	private let apiTransportPublishers: IAPITransportPublishers
	private let imageLoaderPulisher: IImageLoaderPublisher

	private let apiTransport: IAPITransport
	private var imageLoader: IImageLoader
	private let tokenStorage: ITokenStorage
	public weak var friendsViewControllerAssembly: IFriendsViewControllerAssembly?

	public init(
		imageLoaderPulisher: IImageLoaderPublisher,
		apiTransportPublishers: IAPITransportPublishers,
		apiTransport: IAPITransport,
		imageLoader: IImageLoader,
		tokenStorage: ITokenStorage
	) {
		self.apiTransport = apiTransport
		self.imageLoader = imageLoader
		self.tokenStorage = tokenStorage
		self.apiTransportPublishers = apiTransportPublishers
		self.imageLoaderPulisher = imageLoaderPulisher
	}

	public func assembly(userId: Int?, navigationControler: UINavigationController?) -> UIViewController {
		let router = ProfileRouter()
		router.navigationController = navigationControler
		router.friendsViewControllerAssembly = friendsViewControllerAssembly

		let presenter = ProfilePresenter(
			imageLoaderPulisher: imageLoaderPulisher,
			apiTransportPublishers: apiTransportPublishers,
			apiTransport: apiTransport,
			imageLoader: imageLoader,
			tokenStorage: tokenStorage,
			router: router,
			userId: userId
		)

		let viewController = ProfileViewController(presenter: presenter)

		return viewController
	}
}
