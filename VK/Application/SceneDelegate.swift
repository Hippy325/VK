//
//  SceneDelegate.swift
//  VK
//
//  Created by User on 22.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	let di = DI()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: scene)
		window?.makeKeyAndVisible()

		let navigationController = di.mainNavigationController
//		let authorizeViewController = assembly.authorizeViewControllerAssembly.assembly()
//		navigationController.viewControllers = [authorizeViewController]

		window?.rootViewController = navigationController
	}
}

