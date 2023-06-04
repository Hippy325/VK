//
//  MessagesListViewController.swift
//  VK
//
//  Created by User on 03.06.2023.
//

import Foundation
import UIKit

final class MessagesListViewController: UIViewController {

	private let presenter: IMessagesListPresenter

	init(presenter: IMessagesListPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}
