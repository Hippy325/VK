//
//  FriendsViewController.swift
//  VK
//
//  Created by User on 10.05.2023.
//

import Foundation
import UIKit

final class FriendsViewController: UIViewController {
	private let presenter: IFriendsPresenter

	private let tableView = UITableView()

	init(presenter: IFriendsPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
		setupTabBarItem()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .whiteBlack
		setupNavigationItem()
		setup()

		presenter.didLoad()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupTabBarItem() {
		let image = UIImage(systemName: "person.3")?.withTintColor(.gray, renderingMode: .alwaysOriginal)

		let customTabBarItem = UITabBarItem(title: "Friends", image: image, tag: 0)
		customTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textColor], for: .selected)
		customTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .disabled)
		customTabBarItem.selectedImage = image?.withTintColor(.textColor, renderingMode: .alwaysOriginal)
		tabBarItem = customTabBarItem
	}

	private func setupNavigationItem() {
		navigationItem.title = "Друзья"

		let appearance = UINavigationBarAppearance()
		appearance.titleTextAttributes = [.foregroundColor: UIColor.textColor]
		appearance.backgroundColor = .darkGrayBack
		appearance.shadowColor = .clear

		navigationItem.standardAppearance = appearance
		navigationItem.scrollEdgeAppearance = appearance
	}

	private func setup() {
		view.backgroundColor = .darkGrayBack

		view.addSubview(tableView)
		tableView.backgroundColor = .clear
		tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
		tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")

		tableView.dataSource = presenter.tableViewModel()
		tableView.delegate = presenter.tableViewModel()
		tableView.separatorStyle = .none

		setupLayout()

	}

	private func setupLayout() {
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
		])
	}
}

extension FriendsViewController: IFriendsView {
	func reloadData() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
