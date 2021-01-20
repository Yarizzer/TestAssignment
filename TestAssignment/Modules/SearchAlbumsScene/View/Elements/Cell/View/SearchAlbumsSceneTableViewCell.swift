//
//  SearchAlbumsSceneTableViewCell.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

class SearchAlbumsSceneTableViewCell: UITableViewCell {
	func setup(with model: SearchAlbumsSceneTableViewCellViewModelType) {
		self.viewModel = model
		
		userID.text = model.userID
		albumID.text = model.albumID
		albumTitle.text = model.albumTitle
		
		setupView()
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
    
	private var viewModel: SearchAlbumsSceneTableViewCellViewModelType?
	@IBOutlet private weak var userID: UILabel!
	@IBOutlet private weak var albumID: UILabel!
	@IBOutlet private weak var albumTitle: UILabel!
}

extension SearchAlbumsSceneTableViewCell: NibLoadableView {}

extension SearchAlbumsSceneTableViewCell {
	private struct Constants {
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		
		static let minScaleFactor: CGFloat = 0.5
	}
}
