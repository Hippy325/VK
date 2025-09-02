//
//  ProfilePresenter.swift
//  VK
//
//  Created by User on 04.05.2023.
//

import Foundation
import Utilities
import UIKit

final class ProfileViewController: UIViewController {

	private let presenter: IProfilePresenter

	private let tableView = UITableView()
	private let avatarView = UIImageView()

	init(presenter: IProfilePresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
		setupTabBar()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .whiteBlack

		setupTableView()
		presenter.didLoad()

		setupNavigationBar()
	}

	override func viewWillAppear(_ animated: Bool) {
		setupNavigationBar()
	}

	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.navigationBar.prefersLargeTitles = false
		avatarView.removeFromSuperview()
	}

	private func setupTabBar() {
		let image = UIImage(systemName: "person.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal)

		let customTabBarItem = UITabBarItem(title: "Profile", image: image, tag: 0)
		customTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textColor], for: .selected)
		customTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .disabled)
		customTabBarItem.selectedImage = image?.withTintColor(.textColor, renderingMode: .alwaysOriginal)

		tabBarItem = customTabBarItem
	}

	private func setupNavigationBar() {
		guard let navigationBar = navigationController?.navigationBar else { return }
		navigationBar.prefersLargeTitles = true
		navigationBar.addSubview(avatarView)

		avatarView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			avatarView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -3),
			avatarView.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 3),
			avatarView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
			avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor)
		])
	}

	private func setupTableView() {
		view.addSubview(tableView)
		tableView.backgroundColor = .clear
		tableView.dataSource = presenter.dataSource()
		tableView.delegate = presenter.dataSource()
		tableView.separatorStyle = .none

		setupLayoutTableView()
	}

	private func setupLayoutTableView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -25),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
		])
	}
}

extension ProfileViewController: ProfileView {
    func scrollViewDid() {
        self.avatarView.layer.cornerRadius = self.avatarView.frame.height / 2
	}

    func updateAvatar(image: UIImage) {
        self.avatarView.image = image
        self.avatarView.contentMode = .scaleAspectFill
        self.avatarView.layer.masksToBounds = true
        self.avatarView.layer.cornerRadius = self.avatarView.frame.height / 2
	}

    func reloadData() {
        self.tableView.reloadData()
	}
}
