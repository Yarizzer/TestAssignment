//
//  TableViewProviderViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol TableViewProviderViewModel {
	func numberOfTableSections() -> Int
	func numberOfTableRowsInSection(_ section: Int) -> Int
	func heightForRow(atIndex index: Int) -> Float
}
