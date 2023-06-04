//
//  SegmentedControlCell.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation
import UIKit

enum TypeList {
	case Friends
	case Followers
}

protocol HeaderViewDelegate: AnyObject {
	func updateTypeList(typeList: TypeList)
}

final class HeaderView: UITableViewHeaderFooterView {
	weak var delegate: HeaderViewDelegate?
	private let segmentedControll = UISegmentedControl()
	private let titleView = UILabel()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		contentView.backgroundColor = .darkGrayBack

		contentView.addSubview(segmentedControll)
		contentView.addSubview(titleView)

		titleView.backgroundColor = .clear
		titleView.textAlignment = .left
		titleView.textColor = .textColor
		titleView.text = "Мои друзья"

		segmentedControll.backgroundColor = .clear
		segmentedControll.selectedSegmentTintColor = .gray
		segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
//		segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .normal)
		segmentedControll.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .normal)

		segmentedControll.insertSegment(withTitle: "Все друзья", at: 0, animated: true)
		segmentedControll.insertSegment(withTitle: "Подписчики", at: 1, animated: true)

		segmentedControll.addTarget(self, action: #selector(job), for: .valueChanged)
		segmentedControll.selectedSegmentIndex = 0
		setupLayout()
	}

	@objc func job() {
		switch segmentedControll.selectedSegmentIndex {
		case 0:
			titleView.text = "Мои друзья"
			delegate?.updateTypeList(typeList: .Friends)
		case 1:
			titleView.text = "Подписчики"
			delegate?.updateTypeList(typeList: .Followers)
		default:
			break
		}
	}

	private func setupLayout() {
		segmentedControll.translatesAutoresizingMaskIntoConstraints = false
		titleView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			titleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
			titleView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
			titleView.widthAnchor.constraint(equalToConstant: 100),

			segmentedControll.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			segmentedControll.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
			segmentedControll.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
			segmentedControll.leftAnchor.constraint(greaterThanOrEqualTo: titleView.rightAnchor, constant: 10)
		])
	}
}
