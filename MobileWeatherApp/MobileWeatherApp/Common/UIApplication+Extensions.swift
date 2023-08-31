//
//  UIApplication+Extensions.swift
//  MobileWeatherApp
//
//  Created by Renato on 29/08/23.
//

import UIKit

extension UIApplication{
	func endEditing () {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
