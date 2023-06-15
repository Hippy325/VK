//
//  ProfilePresenter.swift
//  VK
//
//  Created by User on 04.05.2023.
//

import Foundation
import Combine
import Storage
import Services
import UIKit

protocol IProfilePresenter {
	func didLoad()
	func dataSource() -> ProfileTableViewDataModel

	var avatarPublisher: PassthroughSubject<UIImage, Never> { get }
	var reloadData: PassthroughSubject<Void, Never> { get }
	var scrollViewDid: PassthroughSubject<Void, Never> { get }
}

final class ProfilePresenter: IProfilePresenter {

	var reloadData: PassthroughSubject<Void, Never> {
		dataSourceModel.reloadData
	}

	var scrollViewDid: PassthroughSubject<Void, Never> {
		dataSourceModel.scrollViewDid
	}
	var avatarPublisher: PassthroughSubject<UIImage, Never> = PassthroughSubject<UIImage, Never>()

	private let apiTransportPublishers: IAPITransportPublishers
	private let imageLoaderPulisher: IImageLoaderPublisher

	private var store = Set<AnyCancellable>()

	private let apiTransport: IAPITransport
	private let imageLoader: IImageLoader
	private let tokenStorage: ITokenStorage
	private let router: IProfileRouter
	private let userId: Int?

	private let dataSourceModel = ProfileTableViewDataModel()

	init(
		imageLoaderPulisher: IImageLoaderPublisher,
		apiTransportPublishers: IAPITransportPublishers,
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
		self.apiTransportPublishers = apiTransportPublishers
		self.imageLoaderPulisher = imageLoaderPulisher
	}

	func didLoad() {
		dataSourceModel.didSelect.receive(on: RunLoop.main)
			.sink { [weak self] section in
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
			.store(in: &store)

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
		apiTransportPublishers.perform(GetPhotosRequest(), userId)
			.map { $0.response }
			.sink { _ in }
				receiveValue: { response in
				self.dataSourceModel.dataModel.albumsInfo = self.transform(photos: response)
			}
			.store(in: &store)
	}

	func loadUserInfo() {
		apiTransportPublishers.perform(GetUsersInfoRequest(), userId)
			.map { $0.response.first }
			.sink { _ in }
				receiveValue: { (user) in
				guard let user = user else { return }
				self.updateAvatarImage(url: user.avatarUrl)
				self.dataSourceModel.dataModel.userInfo = UserInfoCellModel(
					name: user.firstName + " " + user.lastName,
					city: user.city?.title,
					education: user.occupation?.name
				)
			}
			.store(in: &store)
	}

	func loadFriends() {
		apiTransportPublishers.perform(GetFriendsRequest(), userId)
			.map { $0.response }
			.sink { _ in }
			receiveValue: { (response) in
				let items = response.items
				let urlAbsolutes = [items[0].photo, items[1].photo, items[2].photo]

				self.dataSourceModel.dataModel.friendsinfo.count = response.count
				self.imageLoaderPulisher.loadImages(urlAbsolutes: urlAbsolutes)
					.receive(on: DispatchQueue.main)
					.replaceError(with: .custom)
					.sink { self.dataSourceModel.dataModel.friendsinfo.images.append($0) }
					.store(in: &self.store)

			}
			.store(in: &store)
	}

	func transform(
		photos: PhotosInfo
	) -> AlbumsCellModel {
		return 	AlbumsCellModel(
			name: self.dataSourceModel.dataModel.albumsInfo.name,
			count: photos.count,
			photos: photos.items.map({ (photo) -> AlbumsCellModel.AlbumPhoto in
				AlbumsCellModel.AlbumPhoto(date: photo.date, likes: photo.likes) { [weak self] (imageSetter) in
					guard let self = self else { return }
					self.imageLoaderPulisher.loadImage(urlAbsolute: photo.sizes.last!.url)
						.sink { _ in } receiveValue: { imageSetter($0) }
						.store(in: &self.store)
				}
			})
		)
	}

	func updateAvatarImage(url: String) {
		dataSourceModel.dataModel.avatarSetter = { [weak self] (imageSetter) in
			guard let self = self else { return }
			self.imageLoaderPulisher.loadImage(urlAbsolute: url)
				.sink { _ in } receiveValue: { image in
					imageSetter(image)
					self.avatarPublisher.send(image)
				}
				.store(in: &self.store)
		}
	}
}
