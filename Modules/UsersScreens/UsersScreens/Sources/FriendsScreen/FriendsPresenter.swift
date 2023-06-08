//
//  FriendsPresenter.swift
//  VK
//
//  Created by User on 10.05.2023.
//

import Foundation
import Storage
import Services

protocol IFriendsPresenter {
	func tableViewModel() -> FriendsTableViewDataModel
	func didLoad()
}

protocol IFriendsView: AnyObject {
	func reloadData()
}

final class FriendsPresenter: IFriendsPresenter {
	private let router: IFriendsRouter
	private let tokenStorage: ITokenStorage
	private let apiTransport: IAPITransport
	private let imageLoader: IImageLoader
	private let userId: Int?

	private let tableViewDataModel = FriendsTableViewDataModel()

	weak var view: IFriendsView?

	init(
		router: IFriendsRouter,
		tokenStorage: ITokenStorage,
		apiTransport: IAPITransport,
		imageLoader: IImageLoader,
		userId: Int? = nil
	) {
		self.router = router
		self.tokenStorage = tokenStorage
		self.apiTransport = apiTransport
		self.imageLoader = imageLoader
		self.userId = userId
	}

	func tableViewModel() -> FriendsTableViewDataModel {
		tableViewDataModel.headerDelegate = self
		tableViewDataModel.didSelect = { [weak self] userId in
			guard let self = self else { return }
			self.router.goToProfileFriendScreen(userId: userId)
		}

		tableViewDataModel.reloadData = { [weak self] in
			guard let self = self else { return }
			self.view?.reloadData()
		}
		return tableViewDataModel
	}

	func didLoad() {
		loadList(type: .friends)
	}

	private func transform(friendsItem: Item) -> FriendTableViewCellModel {
		FriendTableViewCellModel(
			userId: friendsItem.idd,
			name: friendsItem.firstName + " " + friendsItem.lastName
		) { (imageSetter) in
			self.imageLoader.loadImage(urlAbsolute: friendsItem.photo) { (result) in
				imageSetter(try? result.get())
			}
		}
	}

	private func loadList(type: TypeList) {
		switch type {
		case .friends:
			apiTransport.perform(GetFriendsRequest(), userId) { (result) in
				switch result {
				case .failure:
					print("error")
				case .success(let response):
					self.tableViewDataModel.dataModel = response.response.items.map({ self.transform(friendsItem: $0) })
				}
			}
		case .followers:
			apiTransport.perform(GetUsersFollowers(), userId) { (result) in
				switch result {
				case .failure:
					print("error")
				case .success(let response):
					self.tableViewDataModel.dataModel = response.response.items.map({ self.transform(friendsItem: $0) })
				}
			}
		}
	}
}

extension FriendsPresenter: HeaderViewDelegate {
	func updateTypeList(typeList: TypeList) {
		loadList(type: typeList)
	}
}
