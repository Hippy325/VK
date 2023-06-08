//
//  AuthorizeViewController.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation
import UIKit
import Services

final class AuthorizeViewController: UIViewController {
	private let presenter: IAuthorizePresenter
	private let authorizeView: VKAuthorizeView

	private let indicator = UIActivityIndicatorView()

	init(presenter: IAuthorizePresenter, authorizeView: VKAuthorizeView) {
		self.presenter = presenter
		self.authorizeView = authorizeView
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
//		presenter.goToTabBarScreen()
		view = authorizeView
	}
}
