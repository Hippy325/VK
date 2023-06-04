//
//  FriendsNavigationControllerAssembly.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation
import UIKit

final class FriendsNavigationControllerAssembly: IChaildNavigationControllerAssembly {

	let navigationControllerAssembly: INavigationControllerAssembly
	let friendsViewControllerAssembly: IFriendsViewControllerAssembly

	init(
		navigationControllerAssembly: INavigationControllerAssembly,
		friendsViewControllerAssembly: IFriendsViewControllerAssembly
	) {
		self.navigationControllerAssembly = navigationControllerAssembly
		self.friendsViewControllerAssembly = friendsViewControllerAssembly
	}

	func assembly() -> UINavigationController {
		let navigationController = navigationControllerAssembly.assembly()
		navigationController.viewControllers = [
			friendsViewControllerAssembly.assembly(userId: nil, navigationControler: navigationController)
		]

		return navigationController
	}
}
