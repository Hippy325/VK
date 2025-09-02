//
//  FriendsTableViewDataSource.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation
import UIKit

@MainActor
final class FriendsTableViewDataModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    var reloadData: (() -> Void)?
	var didSelect: ((_ userId: Int) -> Void)?
	weak var headerDelegate: HeaderViewDelegate?

	var dataModel: [FriendTableViewCellModel] = [] {
		didSet {
            reloadData?()
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataModel.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		friendTableViewCell(tableView, indexPath: indexPath)
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return headerView(tableView, section: section)
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 80
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		didSelect?(dataModel[indexPath.row].userId)
	}
}

private extension FriendsTableViewDataModel {
	func friendTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		guard let cell =
				tableView.dequeueReusableCell(
					withIdentifier: "FriendTableViewCell",
					for: indexPath
				) as? FriendTableViewCell
		else { return UITableViewCell() }
		cell.configure(friendModel: dataModel[indexPath.row])
		return cell
	}

	func headerView(_ tableView: UITableView, section: Int) -> UITableViewHeaderFooterView {
		guard
			let header = tableView.dequeueReusableHeaderFooterView(
				withIdentifier: "HeaderView"
			) as? HeaderView
		else {
			return UITableViewHeaderFooterView()
		}
		header.delegate = headerDelegate
		return header
	}
}
