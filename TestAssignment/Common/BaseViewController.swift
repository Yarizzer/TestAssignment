//
//  BaseViewController.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

class BaseViewController<IntreactorT>: UIViewController {
	override func viewDidLoad() { super.viewDidLoad() }
	
	var interactor: IntreactorT?
}
