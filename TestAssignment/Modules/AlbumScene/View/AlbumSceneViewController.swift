//
//  AlbumSceneViewController.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

import UIKit

class AlbumSceneViewController: BaseViewController<AlbumSceneInteractorable> {
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
    }
	
	private func setupView() {
		interactor?.makeRequest(requestType: .initialSetup)
		
		imagePreviewScrollView.layer.cornerRadius = Constants.scrollViewCornerRadiusValue
		imagePreviewScrollView.layer.masksToBounds = true
		imagePreviewScrollView.delegate = self
		imagePreviewScrollView.maximumZoomScale = Constants.maxZoomValue
	}
	
	@IBAction private func saveButtonAction(_ sender: SaveDeleteButton) {
		guard let currentState = sender.currentState else { return }
		
		switch currentState {
		case .save:
			AppCore.shared.appDeviceManager.generateSuccessFeedback()
			interactor?.makeRequest(requestType: .addToLocalStorageAlbum)
		case .delete:
			interactor?.makeRequest(requestType: .askConfirmation)
			AppCore.shared.appDeviceManager.generateFailureFeedback()
		}
	}
	
	private var provider: CollectionViewProviderType?
	@IBOutlet private weak var messageViewTopPaddingConstraint: NSLayoutConstraint!
	@IBOutlet private weak var sceneTitle: UILabel!
	@IBOutlet private weak var saveDeleteButton: SaveDeleteButton!
	@IBOutlet private weak var imagePreviewScrollView: UIScrollView!
	@IBOutlet private weak var selectedImage: UIImageView!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var messageView: MessageView!
}

extension AlbumSceneViewController: AlbumSceneViewControllerType {
    func update(viewModelDataType: AlbumSceneViewControllerViewModel.ViewModelDataType) {
        switch viewModelDataType {
        case .initialSetup(let model):
			sceneTitle.text = model.sceneTitle
			
			model.albumIsInLocalStore.subscribe(self) { [weak self] data in
				guard let isInLocalStorage = data.newValue else { return }
				
				self?.saveDeleteButton.setupState(with: isInLocalStorage ? .delete : .save )
			}
			
			guard let isInLocalStorage = model.albumIsInLocalStore.value else { return }
			
			saveDeleteButton.setupState(with: isInLocalStorage ? .delete : .save )
		case .setupProvider(let model):
			guard let collectionView = collectionView else { return }
			
			view.layoutIfNeeded()
			
			provider = CollectionViewProvider(collectionView: collectionView, viewModel: model as! CollectionViewProviderViewModel)
			provider?.registerCells([AlbumSceneCollectionViewCell.self])
			provider?.onConfigureCell = { [unowned self] indexPath in
				guard let collectionViewProvider = self.provider else { return UICollectionViewCell() }
				
				let collectionViewCell: AlbumSceneCollectionViewCell = collectionViewProvider.dequeueReusableCell(for: indexPath)
				
				guard let viewModel = model.getCollectionViewCellViewModel(for: indexPath.row) else { return collectionViewCell }
				
				collectionViewCell.setup(withModel: viewModel)
				
				return collectionViewCell
			}
			
			provider?.onConfigureCellSize = { [unowned self] indexPath in
				guard let collectionView = self.collectionView else { return CGSize(width: 0, height: 0) }
				
				self.view.layoutIfNeeded()
				
				return CGSize(width: collectionView.frame.height * Constants.cellSizeCoeff, height: collectionView.frame.height * Constants.cellSizeCoeff)
			}
			
			provider?.onSelectCell = { [unowned self] indexPath in
				self.interactor?.makeRequest(requestType: .changeSelectedItemWithItemAt(index: indexPath.row))
			}
			
			self.collectionView.contentInset = UIEdgeInsets(top: Constants.cellSpacingValues.top, left: Constants.cellSpacingValues.left, bottom: Constants.cellSpacingValues.bottom, right: Constants.cellSpacingValues.right)
		case .reloadData: provider?.reloadData()
		case .updatePreviewImage(let data):
			guard let imageData = data else { return }
			
			self.selectedImage.image = UIImage(data: imageData)
			
			UIView.animate(withDuration: Constants.selectedImageAnimationDuration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) { [unowned self] in
				self.selectedImage.alpha = Constants.maxAlphaValue
				self.activityIndicator.alpha = Constants.minAlphaValue
			} completion: { [unowned self] _ in
				activityIndicator.stopAnimating()
				activityIndicator.isHidden = true
				imagePreviewScrollView.isUserInteractionEnabled = true
			}
		case .didChangedSelectedImage:
			activityIndicator.alpha = Constants.maxAlphaValue
			activityIndicator.isHidden = false
			activityIndicator.startAnimating()
			
			UIView.animate(withDuration: Constants.selectedImageAnimationDuration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) { [unowned self] in
				self.selectedImage.alpha = Constants.minAlphaValue
			} completion: { [unowned self] _ in
				imagePreviewScrollView.isUserInteractionEnabled = false
			}
		case .showMessage(let model):
			model.selectedActionType.subscribe(self) { [unowned self] data in
				self.messageView.disapear()
				
				guard let actionType = data.newValue else { return }
				
				UIView.animate(withDuration: Constants.messageViewAnimationDuration, delay: 0, options: [.curveEaseInOut]) { [unowned self] in
					self.messageViewTopPaddingConstraint.constant = 0
					
					self.view.layoutIfNeeded()
				} completion: { _ in
					switch actionType {
					case .dismiss:
						print("\(self) \(#function) Dismissed action")
					case .confirm:
						interactor?.makeRequest(requestType: .removeFromLocalStorageAlbum)
					}
				}
			}
			
			messageView.setup(with: model)
			
			self.view.layoutIfNeeded()
			
			UIView.animate(withDuration: Constants.messageViewAnimationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: [.curveEaseInOut]) { [unowned self] in
				self.messageViewTopPaddingConstraint.constant = AppCore.shared.appDeviceManager.screenSize.height - (AppCore.shared.appDeviceManager.hasTopNotch ? Constants.topConstraintValueWithNotch : Constants.topConstraintValueWithoutNotch) - Constants.topConstraintExtraValue
				self.view.layoutIfNeeded()
			} completion: { _ in
				self.messageView.apear()
			}
        }
    }
}

extension AlbumSceneViewController: UIScrollViewDelegate {
	func viewForZooming(in imagePreviewScrollView: UIScrollView) -> UIView? {
		return selectedImage
	}
}

extension AlbumSceneViewController {
	private struct Constants {
		static let topConstraintValueWithNotch: CGFloat = 44
		static let topConstraintValueWithoutNotch: CGFloat = 24
		static let topConstraintExtraValue: CGFloat = 15
		
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		
		//ScrollView
		static let maxZoomValue: CGFloat = 5.0
		static let scrollViewCornerRadiusValue: CGFloat = 10
		
		//CollectionView
		static let cellSizeCoeff: CGFloat = 0.8
		static let cellSpacingValues = (top: CGFloat(5.0), left: CGFloat(5.0), bottom: CGFloat(5.0), right: CGFloat(5.0))
		
		//Animation
		static let selectedImageAnimationDuration: Double = 1
		static let messageViewAnimationDuration: Double = 0.7
	}
}
