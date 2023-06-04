//
//  FriendsCell.swift
//  VK
//
//  Created by User on 05.05.2023.
//

import Foundation
import UIKit

final class FriendsCell: UITableViewCell {
	private let countView = UILabel()
	private let firstImageView = UIImageView()
	private let secondImageView = UIImageView()
	private let thriedImageView = UIImageView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private func setup() {
		self.backgroundColor = .darkGrayBack
		layer.cornerRadius = 17
		selectionStyle = .none

		addSubview(countView)

		addSubview(thriedImageView)
		addSubview(secondImageView)
		addSubview(firstImageView)

		countView.backgroundColor = .clear
		countView.textColor = .textColor

		setupLayout()
	}

	private func setupLayout() {
		countView.translatesAutoresizingMaskIntoConstraints = false

		thriedImageView.translatesAutoresizingMaskIntoConstraints = false
		secondImageView.translatesAutoresizingMaskIntoConstraints = false
		firstImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			countView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
			countView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
			countView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),

			thriedImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
			thriedImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			thriedImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			thriedImageView.widthAnchor.constraint(equalTo: thriedImageView.heightAnchor),

			secondImageView.rightAnchor.constraint(equalTo: thriedImageView.leftAnchor, constant: 10),
			secondImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			secondImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			secondImageView.widthAnchor.constraint(equalTo: thriedImageView.heightAnchor),

			firstImageView.rightAnchor.constraint(equalTo: secondImageView.leftAnchor, constant: 10),
			firstImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			firstImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			firstImageView.widthAnchor.constraint(equalTo: thriedImageView.heightAnchor)
		])
	}

	func configure(friendsModel: FriendsCellModel) {
		if let count = friendsModel.count {
			countView.text = "друзей \(count)"
		}

//		thriedImageView.image = friendsModel.thriedImage
//		secondImageView.image = friendsModel.secondImage
//		firstImageView.image = friendsModel.firstImage

		friendsModel.loadImages { images in

			self.thriedImageView.image = images[0]
			self.secondImageView.image = images[1]
			self.firstImageView.image = images[2]

			self.setupImages()
		}
	}

	private func setupImages() {
		firstImageView.layer.masksToBounds = true
		firstImageView.layer.cornerRadius = firstImageView.frame.height / 2
		firstImageView.layer.borderWidth = 5
		firstImageView.layer.borderColor = UIColor.darkGrayBack.cgColor

		secondImageView.layer.masksToBounds = true
		secondImageView.layer.cornerRadius = firstImageView.frame.height / 2
		secondImageView.layer.borderWidth = 5
		secondImageView.layer.borderColor = UIColor.darkGrayBack.cgColor

		thriedImageView.layer.masksToBounds = true
		thriedImageView.layer.cornerRadius = firstImageView.frame.height / 2
		thriedImageView.layer.borderWidth = 5
		thriedImageView.layer.borderColor = UIColor.darkGrayBack.cgColor
	}
}
