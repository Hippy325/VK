//
//  UserInfoCell.swift
//  VK
//
//  Created by User on 05.05.2023.
//

import Foundation
import UIKit

final class UserInfoCell: UITableViewCell {
	private let nameView = UILabel()
	private let userInfoView = UILabel()

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

		addSubview(userInfoView)
		addSubview(nameView)

		nameView.backgroundColor = .clear
		userInfoView.backgroundColor = .clear

		nameView.textAlignment = .center
		userInfoView.textAlignment = .center

		nameView.textColor = .textColor
		userInfoView.textColor = .gray

		nameView.font = UIFont.systemFont(ofSize: 25)
		nameView.numberOfLines = 1
		nameView.adjustsFontSizeToFitWidth = true

		setupLayout()
	}

	private func setupLayout() {
		nameView.translatesAutoresizingMaskIntoConstraints = false
		userInfoView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			userInfoView.centerXAnchor.constraint(equalTo: centerXAnchor),
			userInfoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
			userInfoView.heightAnchor.constraint(equalToConstant: 18),

			nameView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			nameView.centerXAnchor.constraint(equalTo: centerXAnchor),
			nameView.bottomAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 4)
		])
	}

	func configure(userInfoModel: UserInfoCellModel) {
		nameView.text = userInfoModel.name
		userInfoView.text = String(userInfoModel.city ?? "") + " " + String(userInfoModel.education ?? "")
	}
}
