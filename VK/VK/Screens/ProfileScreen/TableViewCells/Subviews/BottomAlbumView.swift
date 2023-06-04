//
//  BottomAlbumView.swift
//  VK
//
//  Created by User on 09.05.2023.
//

import Foundation
import UIKit

final class BottomAlbumView: UIView {

	private let likesView = LikesView()

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {

		addSubview(likesView)
		setupLayout()

		likesView.layer.cornerRadius = 21
		likesView.layer.masksToBounds = true
	}

	private func setupLayout() {
		likesView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			likesView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
			likesView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			likesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
			likesView.widthAnchor.constraint(equalToConstant: 100)
		])
	}

	func setupLikes(likes: PhotoLikes) {
		likesView.setupLikes(likes: likes)
	}
}
