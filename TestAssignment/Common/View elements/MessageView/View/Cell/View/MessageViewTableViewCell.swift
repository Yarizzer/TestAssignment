//
//  MessageViewTableViewCell.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

import UIKit

class MessageViewTableViewCell: UITableViewCell {

	func setup(with model: MessageViewTableViewCellViewModelType) {
		self.viewModel = model
		
		self.cellTitle.text = model.title
		
		setupView()
	}
	
	private func setupView() {
		self.backgroundColor = .clear
		
		canvasView.backgroundColor = AppCore.shared.appStyleManager.colorLightGray
		
		canvasView.layer.cornerRadius = Constants.cornerRadiusValue
		canvasView.layer.masksToBounds = true
		
		cellTitle.textColor = AppCore.shared.appStyleManager.colorDarkGray
		cellTitle.font = AppCore.shared.appStyleManager.labelTitleFontLarge
		cellTitle.minimumScaleFactor = Constants.minScaleFactor
		cellTitle.adjustsFontSizeToFitWidth = true
	}
	
	private var viewModel: MessageViewTableViewCellViewModelType?
	
	@IBOutlet private weak var canvasView: UIView!
	@IBOutlet private weak var cellTitle: UILabel!
}

extension MessageViewTableViewCell: NibLoadableView {}

extension MessageViewTableViewCell {
	private struct Constants {
		static let cornerRadiusValue: CGFloat = 20
		static let minScaleFactor: CGFloat = 0.5
	}
}
