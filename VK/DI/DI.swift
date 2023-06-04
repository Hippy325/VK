import Foundation
import UIKit

final class DI: IDI {
	// MARK: - Common
	private lazy var decoder: JSONDecoder = .init()
	private lazy var session: URLSession = .shared

	private lazy var httpTransport: IHTTPTransport = HTTPTransport(session: session, decoder: decoder)

	private lazy var mutableTokenStorage: IMutableTokenStorage = MutableTokenStorage()

	private var tokenStorage: ITokenStorage {
		mutableTokenStorage
	}

	private lazy var apiTransport: IAPITransport = {
		APITransport(httpTransport: httpTransport, tokenStorage: tokenStorage)
	}()

	private var imageLoader: IImageLoader {
		ImageLoader(httpTransport: httpTransport)
	}

	// MARK: - TabBar
	private var tabBarControllerAssembly: ITabBarControllerAssembly {
		TabBarControllerAssembly(
			navigationControllerAssemlyes: [
				profileNavigationControllerAssembly,
				friendsNavigationControllerAssembly
			]
		)
	}

	// MARK: - Navigation
	private var navigationControllerAssembly: INavigationControllerAssembly = NavigationControllerAssembly()

	var mainNavigationController: UINavigationController {
		let navigationController = mainNavigationControllerAssembly.assembly()
		navigationController.viewControllers = [
			authorizeViewControllerAssembly.assembly(navigationController: navigationController)
		]

		return navigationController
	}
	private var mainNavigationControllerAssembly: IMainNavigationControllerAssembly = MainNavigationControllerAssembly()

	// MARK: - ChaildNavigation

	private var profileNavigationControllerAssembly: IChaildNavigationControllerAssembly {
		ProfileNavigationControllerAssembly(
			navigationControllerAssembly: navigationControllerAssembly,
			profileViewControllerAssembly: profileViewControllerAssembly
		)
	}

	private var friendsNavigationControllerAssembly: IChaildNavigationControllerAssembly {
		FriendsNavigationControllerAssembly(
			navigationControllerAssembly: navigationControllerAssembly,
			friendsViewControllerAssembly: friendsViewControllerAssembly
		)
	}

	// MARK: - Screens
	private var authorizeViewControllerAssembly: IAuthorizeViewControllerAssembly {
		AuthorizeViewControllerAssembly(
			tokenStorage: mutableTokenStorage,
			tabBarControllerAssembly: tabBarControllerAssembly
		)
	}

	private lazy var profileViewControllerAssembly: IProfileViewControllerAssembly = ProfileViewControllerAssembly(
		apiTransport: apiTransport,
		imageLoader: imageLoader,
		tokenStorage: tokenStorage
	)

	private var friendsViewControllerAssembly: IFriendsViewControllerAssembly {
		let assembly = FriendsViewControllerAssembly(
			profileViewControllerAssembly: profileViewControllerAssembly,
			tokenStorage: tokenStorage,
			apiTransport: apiTransport,
			imageLoader: imageLoader
		)
		profileViewControllerAssembly.friendsViewControllerAssembly = assembly
		return assembly
	}
}
