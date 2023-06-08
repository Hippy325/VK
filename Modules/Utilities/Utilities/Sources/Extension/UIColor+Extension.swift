//
//  ExtensionUIColor.swift
//  VK
//
//  Created by User on 12.05.2023.
//

import Foundation
import UIKit

public extension UIColor {
	static var darkGrayBack = UIColor(named: "darkGrayBack")
		?? UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1)
	static var whiteBlack = UIColor(named: "whiteBlack") ?? .black
	static var textColor = UIColor(named: "textColor") ?? .white
}
