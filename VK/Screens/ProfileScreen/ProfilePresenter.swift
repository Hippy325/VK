//
//  ProfilePresenter.swift
//  VK
//
//  Created by User on 04.05.2023.
//

import Foundation
import UIKit

protocol IProfilePresenter {
	func didLoad()
	func dataSource() -> ProfileTableViewDataModel
}

protocol ProfileView: AnyObject {
	func reloadData()
	func updateAvatar(image: UIImage)
	func scrollViewDid()
}

final class ProfilePresenter: IProfilePresenter {
	private let apiTransport: IAPITransport
	private let imageLoader: IImageLoader
	private let tokenStorage: ITokenStorage
	private let router: IProfileRouter
	private let userId: Int?

	private let dataSourceModel = ProfileTableViewDataModel()

	weak var view: ProfileView?

	init(
		apiTransport: IAPITransport,
		imageLoader: IImageLoader,
		tokenStorage: ITokenStorage,
		router: IProfileRouter,
		userId: Int? = nil
	) {
		self.apiTransport = apiTransport
		self.imageLoader = imageLoader
		self.tokenStorage = tokenStorage
		self.router = router
		self.userId = userId
	}

	func didLoad() {
		dataSourceModel.didScroll = { [weak self] in
			guard let self = self else { return }
			self.view?.scrollViewDid()
		}

		dataSourceModel.reloadData = { [weak self] in
			guard let self = self else { return }
			self.view?.reloadData()
		}

		dataSourceModel.didSelect = { [weak self] section in
			guard let self = self else { return }
			switch section {
			case .friends:
				self.router.goToFriendsScreen(userId: self.userId)
			case .user:
				print("user")
			case .photo(let photo):
				print(photo.date)
			}
		}

		loadUserInfo()
		loadFriends()
		loadAlbumsInfo()
	}

	func dataSource() -> ProfileTableViewDataModel {
		return dataSourceModel
	}
}

private extension ProfilePresenter {
	func loadAlbumsInfo() {
		apiTransport.perform(GetPhotosRequest(), userId) { (result) in
			switch result {
			case .success(let response):
				self.dataSourceModel.dataModel.albumsInfo = self.transform(photos: response.response)
			case .failure(let error):
				print(error)
			}
		}
	}

	func loadUserInfo() {
		apiTransport.perform(GetUsersInfoRequest(), userId) { (result) in
			switch result {
			case .success(let data):
				guard let user = data.response.first else {
					return
				}
				self.updateAvatarImage(url: user.avatarUrl)
				self.dataSourceModel.dataModel.userInfo = UserInfoCellModel(
					name: user.firstName + " " + user.lastName,
					city: user.city?.title,
					education: user.occupation?.name
				)
				self.dataSourceModel.dataModel.albumsInfo.name = user.firstName + " " + user.lastName
			case .failure(_):
				print("huy tam")
			}
		}
	}

	func loadFriends() {
		apiTransport.perform(GetFriendsRequest(), userId) { (result) in
			switch result {
			case .success(let response):
				let items = response.response.items

				let urlAboluts = [items[0].photo, items[1].photo, items[2].photo]

				self.dataSourceModel.dataModel.friendsinfo = FriendsCellModel(
					count: response.response.count,
					firstImage: nil,
					secondImage: nil,
					thriedImage: nil,
					loadImages: { imagesSetter in
						self.imageLoader.loadImages(urlAbsolutes: urlAboluts) { (result) in
							imagesSetter(try! result.get())
						}
					}
				)
			case .failure(_):
				print("error")
			}
		}
	}

	func transform(
		photos: PhotosInfo
	) -> AlbumsCellModel {
		return 	AlbumsCellModel(
			name: self.dataSourceModel.dataModel.albumsInfo.name,
			count: photos.count,
			photos: photos.items.map({ (photo) -> AlbumsCellModel.AlbumPhoto in
				AlbumsCellModel.AlbumPhoto(date: photo.date, likes: photo.likes) { (imageSetter) in
					self.imageLoader.loadImage(urlAbsolute: photo.sizes.last!.url) { (result) in
						imageSetter(try? result.get())
					}
				}
			})
		)
	}

	func updateAvatarImage(url: String) {
		dataSourceModel.dataModel.avatarSetter = { (imageSetter) in
			self.imageLoader.loadImage(urlAbsolute: url) { (result) in
				switch result {
				case .success(let image):
					self.view?.updateAvatar(image: image)
					imageSetter(image)
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}
