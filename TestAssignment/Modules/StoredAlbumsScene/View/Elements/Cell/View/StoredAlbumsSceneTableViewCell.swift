//
//  StoredAlbumsSceneTableViewCell.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 17.01.2021.
//

import UIKit

class StoredAlbumsSceneTableViewCell: UITableViewCell {
	func setup(with model: StoredAlbumsSceneTableViewCellViewModelType) {
		self.viewModel = model
		
		setupView()
		
		userID.text = model.userID
		albumID.text = model.albumID
		albumTitle.text = model.albumTitle
	}
	
	private func setupView() {
		userID.minimumScaleFactor = Constants.minScaleFactor
		userID.adjustsFontSizeToFitWidth = true
		
		albumID.minimumScaleFactor = Constants.minScaleFactor
		albumID.adjustsFontSizeToFitWidth = true
		
		albumTitle.numberOfLines = 0
		albumTitle.minimumScaleFactor = Constants.minScaleFactor
		albumTitle.adjustsFontSizeToFitWidth = true
	}
	
	private var viewModel: StoredAlbumsSceneTableViewCellViewModelType?
	@IBOutlet private weak var userID: UILabel!
	@IBOutlet private weak var albumID: UILabel!
	@IBOutlet private weak var albumTitle: UILabel!
}

extension StoredAlbumsSceneTableViewCell: NibLoadableView {}

extension StoredAlbumsSceneTableViewCell {
	private struct Constants {
		static let minScaleFactor: CGFloat = 0.5
	}
}
