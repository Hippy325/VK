//
//  TitleViewForRecord.swift
//  VK
//
//  Created by User on 09.05.2023.
//

import Foundation
import UIKit

final class TitleViewForRecord: UIView {
	private let dateView = UILabel()
	private let avatarView = UIImageView()
	private let nameView = UILabel()
	private let stackView = UIStackView()

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {

		addSubview(avatarView)
		addSubview(stackView)

		stackView.axis = .vertical
		stackView.alignment = .leading
		stackView.addArrangedSubview(nameView)
		stackView.addArrangedSubview(dateView)

		nameView.backgroundColor = .clear
		dateView.backgroundColor = .clear

		nameView.textColor = .textColor
		dateView.textColor = .gray

		nameView.textAlignment = .left
		dateView.textAlignment = .left

		nameView.font = UIFont.systemFont(ofSize: 20)

		setupLayout()
	}

	private func setupLayout() {
		avatarView.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			avatarView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
			avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
			avatarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
			avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor),

			stackView.leftAnchor.constraint(equalTo: avatarView.rightAnchor, constant: 5),
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
			stackView.rightAnchor.constraint(equalTo: rightAnchor)
		])
	}

	func updateAvatar(avatarImage: UIImage?) {
		DispatchQueue.main.async {
			self.avatarView.image = avatarImage
			self.avatarView.contentMode = .scaleAspectFill
			self.avatarView.layer.masksToBounds = true
			self.avatarView.layer.cornerRadius = self.avatarView.frame.height / 2
		}
	}

	func updateName(name: String) {
		nameView.text = name
	}

	func configureDate(date: Int) {
		let dateFormater = DateFormatter()
		dateFormater.dateFormat = "dd:MM:yyyy"
		dateView.text = dateFormater.string(from: Date(timeIntervalSince1970: Double(date)))
	}
}
