//
//  MainNavigationControllerAssembly.swift
//  VK
//
//  Created by User on 11.05.2023.
//

import Foundation
import UIKit

protocol IMainNavigationControllerAssembly {
	func assembly() -> UINavigationController
}

final class MainNavigationControllerAssembly: IMainNavigationControllerAssembly {
	func assembly() -> UINavigationController {
		let navigationController = UINavigationController()
		navigationController.navigationBar.isHidden = true

		return navigationController
	}
}
