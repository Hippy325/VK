//
//  MainNavigationControllerAssembly.swift
//  VK
//
//  Created by User on 11.05.2023.
//

import Foundation
import UIKit

@MainActor
public protocol IMainNavigationControllerAssembly: Sendable {
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
