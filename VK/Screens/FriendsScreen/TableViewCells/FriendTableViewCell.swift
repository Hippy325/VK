//
//  FriendTableViewCell.swift
//  VK
//
//  Created by User on 13.05.2023.
//

import Foundation
import UIKit

final class FriendTableViewCell: UITableViewCell {

	private let avatarView = UIImageView()
	private let nameView = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		backgroundColor = .clear
		selectionStyle = .none

		addSubview(avatarView)
		addSubview(nameView)

		nameView.backgroundColor = .clear
		nameView.text = "Huy"

		setupLayout()
	}

	private func setupLayout() {
		avatarView.translatesAutoresizingMaskIntoConstraints = false
		nameView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			avatarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			avatarView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
			avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),

			nameView.centerYAnchor.constraint(equalTo: centerYAnchor),
			nameView.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 10)
		])
	}

	func configure(friendModel: FriendTableViewCellModel) {
		nameView.text = friendModel.name

		friendModel.avatarSetter { image in
			DispatchQueue.main.async {
				self.avatarView.image = image
				self.setupAvatarView()
			}
		}
	}

	private func setupAvatarView() {
		avatarView.layer.cornerRadius = avatarView.frame.height / 2
		avatarView.layer.masksToBounds = true
	}
}
