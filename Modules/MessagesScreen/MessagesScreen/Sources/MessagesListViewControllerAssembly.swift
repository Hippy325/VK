//
//  MessagesListViewControllerAssembly.swift
//  VK
//
//  Created by User on 03.06.2023.
//

import Foundation
import UIKit

protocol IMessagesListViewControllerAssembly {
	func assembly() -> UIViewController
}

final class MessagesListViewControllerAssembly: IMessagesListViewControllerAssembly {
	func assembly() -> UIViewController {
		let router = MessagesListRouter()

		let presenter = MessagesListPresenter(router: router)

		let viewController = MessagesListViewController(presenter: presenter)
		return viewController
	}
}
