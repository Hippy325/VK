//
//  ProfilePresenter.swift
//  VK
//
//  Created by User on 04.05.2023.
//

import Foundation
import Storage
import Services
import UIKit

@MainActor
protocol IProfilePresenter: Sendable {
    func didLoad()
    func dataSource() -> ProfileTableViewDataModel
}

@MainActor
protocol ProfileView: AnyObject, Sendable {
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
    
    nonisolated func dataSource() -> ProfileTableViewDataModel {
        return dataSourceModel
    }
}

private extension ProfilePresenter {
    func loadAlbumsInfo() {
        Task {
            let result = try await apiTransport.perform(GetPhotosRequest(), userId)
            self.dataSourceModel.dataModel.albumsInfo = self.transform(photos: result.response)
        }
    }
    
    func loadUserInfo() {
        Task {
            let result = try await apiTransport.perform(GetUsersInfoRequest(), userId)
            guard let user = result.response.first else {
                return
            }
            self.updateAvatarImage(url: user.avatarUrl)
            self.dataSourceModel.dataModel.userInfo = UserInfoCellModel(
                name: user.firstName + " " + user.lastName,
                city: user.city?.title,
                education: user.occupation?.name
            )
            self.dataSourceModel.dataModel.albumsInfo.name = user.firstName + " " + user.lastName
        }
    }
    
    func loadFriends() {
        Task {
            let result = try await apiTransport.perform(GetFriendsRequest(), userId)
            let items = result.response.items
            let urlAboluts = [items[0].photo, items[1].photo, items[2].photo]
            self.dataSourceModel.dataModel.friendsinfo = FriendsCellModel(
                count: result.response.count,
                firstImage: nil,
                secondImage: nil,
                thriedImage: nil,
                loadImages: { imagesSetter in
                    do {
                        let images = try await self.imageLoader.loadImages(urlAbsolutes: urlAboluts)
                        imagesSetter(images)
                    } catch let error {
                        print(error)
                    }
                }
            )
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
                    do {
                        let image = try await self.imageLoader.loadImage(urlAbsolute: photo.sizes.last!.url)
                        imageSetter(image)
                    } catch let error {
                        print(error)
                    }
                }
            })
        )
    }
    
    func updateAvatarImage(url: String) {
        dataSourceModel.dataModel.avatarSetter = { (imageSetter) async in
            do {
                let image = try await self.imageLoader.loadImage(urlAbsolute: url)
                self.view?.updateAvatar(image: image)
                imageSetter(image)
            } catch let error {
                print(error)
            }
        }
    }
}
