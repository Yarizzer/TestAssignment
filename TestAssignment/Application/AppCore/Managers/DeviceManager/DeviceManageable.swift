//
//  DeviceManageable.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

import UIKit

protocol DeviceManageable {
	var screenSize: CGRect { get }
	var hasTopNotch: Bool { get }
	
	func generateSuccessFeedback()
	func generateFailureFeedback()
}
