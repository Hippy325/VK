//
//  AuthorizePresenter.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation

protocol IAuthorizePresenter {
	func goToTabBarScreen()
}

final class AuthorizePresenter: IAuthorizePresenter {
	private let router: IAuthorizeRouter
	private let tokenStorage: IMutableTokenStorage

	init(router: IAuthorizeRouter, tokenStorage: IMutableTokenStorage) {
		self.router = router
		self.tokenStorage = tokenStorage
	}

	func goToTabBarScreen() {
		router.goToTabBarScreen()
	}
}

extension AuthorizePresenter: IAuthorizeDelegate {
	func user(token: String) {
		tokenStorage.token = token
		router.goToTabBarScreen()
		router.presentAlertAuthorized()
	}
}
