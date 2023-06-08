//
//  MessagesListPresenter.swift
//  VK
//
//  Created by User on 03.06.2023.
//

import Foundation

protocol IMessagesListPresenter {

}

final class MessagesListPresenter: IMessagesListPresenter {

	private let router: IMessagesListRouter

	init(router: IMessagesListRouter) {
		self.router = router
	}
}
