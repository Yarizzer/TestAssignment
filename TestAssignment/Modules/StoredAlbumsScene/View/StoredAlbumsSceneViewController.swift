//
//  StoredAlbumsSceneViewController.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

class StoredAlbumsSceneViewController: BaseViewController<StoredAlbumsSceneInteractorable> {
	
    // MARK: View lifecycle
    override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
    }
	
	private func setupView() {
		interactor?.makeRequest(requestType: .setupProvider)
	}
	
	private var provider: TableViewProviderType?
	@IBOutlet private weak var messageViewTopPaddingConstraint: NSLayoutConstraint!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var messageView: MessageView!
}

extension StoredAlbumsSceneViewController: StoredAlbumsSceneViewControllerType {
    func update(viewModelDataType: StoredAlbumsSceneViewControllerViewModel.ViewModelDataType) {
        switch viewModelDataType {
        case .setupProvider(let model):
			self.provider = TableViewProvider(for: self.tableView, with: model as! StoredAlbumsSceneViewModel)
			self.provider?.registerCells([StoredAlbumsSceneTableViewCell.self])
			
			self.provider?.onConfigureCell = { [unowned self] indexPath in
				
				guard let provider = self.provider else { return UITableViewCell() }

				let tebleViewCell: StoredAlbumsSceneTableViewCell = provider.dequeueReusableCell(for: indexPath)

				guard let model = model.getStoredAlbumsTableViewCellViewModelType(with: indexPath.row) else { return tebleViewCell }

				tebleViewCell.setup(with: model)

				return tebleViewCell
			}

			self.provider?.onSlidedCell = { [unowned self] indexPath in

				let addToLocalStorageAction = UIContextualAction(style: .normal, title: model.removeFromLocalStorageActionTitle) { (_, _, completionHandler) in
					self.interactor?.makeRequest(requestType: .setSlidedAlbum(withIndex: indexPath.row))

					completionHandler(true)
				}

				return UISwipeActionsConfiguration(actions: [addToLocalStorageAction])
			}

			self.provider?.onSelectCell = { [unowned self] indexPath in
				interactor?.makeRequest(requestType: .routeToAlbumScene(withIndex: indexPath.row))
			}
		case .reloadData: provider?.reloadData()
		case .showMessage(let model):
			AppCore.shared.appDeviceManager.generateSuccessFeedback()
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
				self.messageViewTopPaddingConstraint.constant = -AppCore.shared.appDeviceManager.screenSize.height + (AppCore.shared.appDeviceManager.hasTopNotch ? Constants.topConstraintValueWithNotch : Constants.topConstraintValueWithoutNotch)
				self.view.layoutIfNeeded()
			} completion: { _ in
				self.messageView.apear()
			}
        }
    }
}

extension StoredAlbumsSceneViewController {
	private struct Constants {
		static let topConstraintValueWithNotch: CGFloat = 44
		static let topConstraintValueWithoutNotch: CGFloat = 24
		
		//Animation
		static let messageViewAnimationDuration: Double = 0.7
	}
}
