//
//  ITokenStorage.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation

protocol ITokenStorage {
	var token: String? { get}
}

protocol IMutableTokenStorage: AnyObject, ITokenStorage {
	var token: String? { get set }
}
