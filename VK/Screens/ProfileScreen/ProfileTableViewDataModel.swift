//
//  DetailTableViewDataSource.swift
//  VK
//
//  Created by User on 06.05.2023.
//

import Foundation
import UIKit

final class ProfileTableViewDataModel: NSObject, UITableViewDataSource {
	enum SectionType {
		case friends
		case user
		case photo(_ albumPhoto: AlbumsCellModel.AlbumPhoto)
	}

	var didScroll: (() -> Void)?
	var reloadData: (() -> Void)?
	var didSelect: ((_ section: SectionType) -> Void)?

	var dataModel = GeneralModel(
		userInfo: UserInfoCellModel(name: "", city: "", education: ""),
		friendsinfo: FriendsCellModel(count: nil, firstImage: nil, secondImage: nil, thriedImage: nil, loadImages: { _ in}),
		albumsInfo: AlbumsCellModel(name: "", count: 0, photos: []),
		avatarSetter: { _ in }
	) {
		didSet {
			reloadData?()
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 1
		case 1:
			return 1
		case 2:
			return dataModel.albumsInfo.count
		default:
			return 2
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			return userInfoCell()
		case 1:
			return friendsCell()
		case 2:
			return albumCell(indexPath: indexPath)
		default:
			return UITableViewCell()
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		3
	}
}

extension ProfileTableViewDataModel: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case 0:
			return 80
		case 1:
			return 70
		case 2:
			return 600
		default:
			return 100
		}
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = .clear
		return headerView
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		didScroll?()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 0:
			didSelect?(.user)
		case 1:
			didSelect?(.friends)
		case 2:
			didSelect?(.photo(dataModel.albumsInfo.photos[indexPath.row]))
		default:
			break
		}
	}
}

private extension ProfileTableViewDataModel {
	func userInfoCell() -> UserInfoCell {
		let cell = UserInfoCell()
		cell.configure(userInfoModel: dataModel.userInfo)
		return cell
	}

	func friendsCell() -> FriendsCell {
		let cell = FriendsCell()
		cell.configure(friendsModel: dataModel.friendsinfo)
		return cell
	}

	func albumCell(indexPath: IndexPath) -> AlbumCell {
		let cell = AlbumCell()
		cell.configure(albumModel: dataModel.albumsInfo.photos[indexPath.row])
		cell.updateNameTitle(name: dataModel.userInfo.name)

		dataModel.avatarSetter { image in
			cell.updateTitleAvatar(userImage: image)
		}
		
		return cell
	}
}
