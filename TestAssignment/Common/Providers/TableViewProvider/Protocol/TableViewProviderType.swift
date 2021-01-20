//
//  TableViewProviderType.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol TableViewProviderType {
	var onConfigureCell: ((IndexPath) -> UITableViewCell)? { get set }
	var onSelectCell: ((IndexPath) -> Void)? { get set }
	var onSlidedCell: ((IndexPath) -> UISwipeActionsConfiguration?)? { get set }
	func registerCells(_ cells: [UITableViewCell.Type])
	func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell
	func reloadData()
}
