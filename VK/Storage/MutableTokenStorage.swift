//
//  MutableTokenStorage.swift
//  VK
//
//  Created by User on 02.05.2023.
//

import Foundation

final class MutableTokenStorage: IMutableTokenStorage {
	var token: String? {
		get {
			UserDefaults.standard.string(forKey: "kek_token")
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "kek_token")
		}
	}
}
