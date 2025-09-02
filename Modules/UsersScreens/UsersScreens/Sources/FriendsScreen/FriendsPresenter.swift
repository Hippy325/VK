//
//  FriendsPresenter.swift
//  VK
//
//  Created by User on 10.05.2023.
//

import Foundation
import Storage
import Services

@MainActor
protocol IFriendsPresenter: Sendable {
    func tableViewModel() -> FriendsTableViewDataModel
    func didLoad()
}

@MainActor
protocol IFriendsView: AnyObject, Sendable {
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
    
    func tableViewModel() ->  FriendsTableViewDataModel {
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
        ) { imageSetter in
            Task {
                let image = try await self.imageLoader.loadImage(urlAbsolute: friendsItem.photo)
                imageSetter(image)
            }
        }
    }
    
    private func loadList(type: TypeList) {
        Task {
            switch type {
            case .friends:
                let result = try await apiTransport.perform(GetFriendsRequest(), userId)
                self.tableViewDataModel.dataModel = result.response.items.map { self.transform(friendsItem: $0) }
            case .followers:
                let result = try await apiTransport.perform(GetUsersFollowers(), userId)
                self.tableViewDataModel.dataModel = result.response.items.map { self.transform(friendsItem: $0) }
            }
        }
    }
}

extension FriendsPresenter: HeaderViewDelegate {
    func updateTypeList(typeList: TypeList) {
        loadList(type: typeList)
    }
}
