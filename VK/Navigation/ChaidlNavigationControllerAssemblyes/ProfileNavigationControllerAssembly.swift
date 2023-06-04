//
//  ProfileNavigationControllerAssembly.swift
//  VK
//
//  Created by User on 10.05.2023.
//

import Foundation
import UIKit

final class ProfileNavigationControllerAssembly: IChaildNavigationControllerAssembly {
	let navigationControllerAssembly: INavigationControllerAssembly
	let profileViewControllerAssembly: IProfileViewControllerAssembly

	init(
		navigationControllerAssembly: INavigationControllerAssembly,
		profileViewControllerAssembly: IProfileViewControllerAssembly
	) {
		self.navigationControllerAssembly = navigationControllerAssembly
		self.profileViewControllerAssembly = profileViewControllerAssembly
	}

	func assembly() -> UINavigationController {
		let navigationController = navigationControllerAssembly.assembly()
		navigationController.navigationBar.prefersLargeTitles = true
		navigationController.viewControllers = [
			profileViewControllerAssembly.assembly(userId: nil, navigationControler: navigationController)
		]

		return navigationController
	}
}
