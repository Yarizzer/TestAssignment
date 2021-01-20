//
//  AlbumScenePresenter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

class AlbumScenePresenter {
    init(for view: AlbumSceneViewControllerType, service: AlbumScenePresenterServiceType) {
        self.viewController = view
        self.service = service
    }
	
	private func runSubscription() {
		let model = service.getViewModel()
		
		model.shouldUpdateDate.subscribe(self) { [unowned self] in
			guard let needToUpdate = $0.newValue else { return }
			
			if needToUpdate {
				self.viewController.update(viewModelDataType: .reloadData)
			}
		}
		
		model.didChangedSelectedItem.subscribe(self) { [unowned self] in
			guard let didChangedSelectedItem = $0.newValue else { return }
			
			if didChangedSelectedItem {
				self.viewController.update(viewModelDataType: .didChangedSelectedImage)
			}
		}
		
		model.previewImageData.subscribe(self) { [unowned self] in
			self.viewController.update(viewModelDataType: .updatePreviewImage(with: $0.newValue))
		}
	}
    
    private var viewController: AlbumSceneViewControllerType
    private var service: AlbumScenePresenterServiceType
}

extension AlbumScenePresenter: AlbumScenePresenterable {
    func response(responseType: AlbumScenePresenterResponse.AlbumSceneResponseType) {
		let model = service.getViewModel()
		
        switch responseType {
        case .initialSetup:
			viewController.update(viewModelDataType: .initialSetup(with: model))
			viewController.update(viewModelDataType: .setupProvider(with: model))
			self.runSubscription()
		case .showMessageView(let type):
			viewController.update(viewModelDataType: .showMessage(withModel: service.getMessageViewModel(for: type)))
        }
    }
}
