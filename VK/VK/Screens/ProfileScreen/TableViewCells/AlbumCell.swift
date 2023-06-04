//
//  Album.swift
//  VK
//
//  Created by User on 07.05.2023.
//

import Foundation
import UIKit

final class AlbumCell: UITableViewCell {

	private let backgroundViewCell = UIView()
	private let avatarView = UIImageView()
	private let titleView = TitleViewForRecord()
	private let bottomView = BottomAlbumView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {


		self.backgroundColor = .clear
		selectionStyle = .none
		backgroundViewCell.layer.cornerRadius = 17
		backgroundViewCell.backgroundColor = .darkGrayBack

		self.addSubview(backgroundViewCell)
		backgroundViewCell.addSubview(avatarView)
		backgroundViewCell.addSubview(titleView)
		backgroundViewCell.addSubview(bottomView)

		bottomView.backgroundColor = .clear

		setupLayout()
	}

	private func setupLayout() {
		backgroundViewCell.translatesAutoresizingMaskIntoConstraints = false
		avatarView.translatesAutoresizingMaskIntoConstraints = false
		titleView.translatesAutoresizingMaskIntoConstraints = false
		bottomView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			backgroundViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
			backgroundViewCell.leftAnchor.constraint(equalTo: leftAnchor),
			backgroundViewCell.rightAnchor.constraint(equalTo: rightAnchor),

			titleView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor),
			titleView.heightAnchor.constraint(equalToConstant: 60),
			titleView.leftAnchor.constraint(equalTo: backgroundViewCell.leftAnchor),
			titleView.rightAnchor.constraint(equalTo: backgroundViewCell.rightAnchor),

			bottomView.bottomAnchor.constraint(equalTo: backgroundViewCell.bottomAnchor),
			bottomView.heightAnchor.constraint(equalToConstant: 50),
			bottomView.leftAnchor.constraint(equalTo: backgroundViewCell.leftAnchor),
			bottomView.rightAnchor.constraint(equalTo: backgroundViewCell.rightAnchor),

			avatarView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
			avatarView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
			avatarView.leftAnchor.constraint(equalTo: backgroundViewCell.leftAnchor),
			avatarView.rightAnchor.constraint(equalTo: backgroundViewCell.rightAnchor)
		])
	}

	func configure(albumModel: AlbumsCellModel.AlbumPhoto) {
		albumModel.loadImages { image in
			DispatchQueue.main.async {
				self.avatarView.image = image
			}
		}
		titleView.configureDate(date: albumModel.date)
		bottomView.setupLikes(likes: albumModel.likes)
	}

	func updateNameTitle(name: String) {
		titleView.updateName(name: name)
	}

	func updateTitleAvatar(userImage: UIImage?) {
		titleView.updateAvatar(avatarImage: userImage)
	}
}


