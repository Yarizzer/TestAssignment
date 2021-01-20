//
//  NibLoadableView.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol NibLoadableView: class {
	static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
	static var nibName: String {
		return String(describing: self)
	}
}

extension NibLoadableView where Self: UIViewController {
	static var nibName: String {
		return String(describing: self)
	}
}
