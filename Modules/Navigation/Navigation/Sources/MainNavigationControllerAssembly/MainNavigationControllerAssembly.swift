//
//  MainNavigationControllerAssembly.swift
//  VK
//
//  Created by User on 11.05.2023.
//

import Foundation
import UIKit

public protocol IMainNavigationControllerAssembly {
	func assembly() -> UINavigationController
}

public final class MainNavigationControllerAssembly: IMainNavigationControllerAssembly {
	public init() {}

	public func assembly() -> UINavigationController {
		let navigationController = UINavigationController()
		navigationController.navigationBar.isHidden = true

		return navigationController
	}
}
