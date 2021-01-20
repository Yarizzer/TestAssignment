//
//  AlbumSceneCollectionViewCell.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

import UIKit

class AlbumSceneCollectionViewCell: UICollectionViewCell {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		imageView.layer.cornerRadius = Constants.imageCornerRadiusValue
		imageView.layer.masksToBounds = true
		
		self.clipsToBounds = false
	}

	func setup(withModel model: AlbumSceneCollectionViewCellViewModelType) {
		viewModel = model
		
		itemTitle.text = model.itemTitle
		
		setupView()
		
		setupSubscription()
		model.preparePublisher()
	}
	
	private func setupSubscription() {
		guard let model = viewModel else { return }
		
		model.imageData.subscribe(self) { [unowned self] in
			guard let imageData = $0.newValue else { return }

			self.imageView.image = UIImage(data: imageData)
			
			UIView.animate(withDuration: Constants.imageAppearAnimationDuration, delay: 0, options: [.curveEaseInOut], animations: { [unowned self] in
				self.imageView.alpha = Constants.maxAlphaValue
				self.activityIndicator.stopAnimating()
				self.activityIndicator.alpha = Constants.minAlphaValue
			})
		}
	}
	
	private func setupView() {
		itemTitle.numberOfLines = 0
		itemTitle.minimumScaleFactor = Constants.minScaleFactor
		itemTitle.adjustsFontSizeToFitWidth = true
		
		imageView.alpha = Constants.minAlphaValue
		imageView.contentMode = .scaleAspectFill
		
		activityIndicator.startAnimating()
		activityIndicator.alpha = Constants.maxAlphaValue
	}

	private var viewModel: AlbumSceneCollectionViewCellViewModelType?
	@IBOutlet private weak var canvasView: UIView!
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var itemTitle: UILabel!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
}

extension AlbumSceneCollectionViewCell: NibLoadableView {}

extension AlbumSceneCollectionViewCell {
	private struct Constants {
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		
		static let minScaleFactor: CGFloat = 0.5

		static let imageCornerRadiusValue: CGFloat = 48
		//Animation
		static let imageAppearAnimationDuration: Double = 0.5
	}
}
