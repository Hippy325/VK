//
//  ITokenStorage.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation

public  protocol ITokenStorage: Sendable {
	var token: String? { get}
}

public protocol IMutableTokenStorage: AnyObject, ITokenStorage {
	var token: String? { get set }
}
