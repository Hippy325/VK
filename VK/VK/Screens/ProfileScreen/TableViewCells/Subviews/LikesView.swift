//
//  LikesView.swift
//  VK
//
//  Created by User on 09.05.2023.
//

import Foundation
import UIKit

final class LikesView: UIView {

	private let countView = UILabel()

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		backgroundColor = .systemGray

		addSubview(countView)

		countView.backgroundColor = .clear
		countView.textColor = .textColor
		countView.textAlignment = .center

		setupLayout()
	}

	private func setupLayout() {
		countView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			countView.leftAnchor.constraint(equalTo: leftAnchor),
			countView.topAnchor.constraint(equalTo: topAnchor),
			countView.bottomAnchor.constraint(equalTo: bottomAnchor),
			countView.rightAnchor.constraint(equalTo: rightAnchor)
		])
	}

	func setupLikes(likes: PhotoLikes) {
		countView.text = "likes \(likes.count)"

		switch likes.userLike {
		case 1:
			backgroundColor = UIColor(named: "likesRed")
		default:
			backgroundColor = .systemGray
		}
	}
}
