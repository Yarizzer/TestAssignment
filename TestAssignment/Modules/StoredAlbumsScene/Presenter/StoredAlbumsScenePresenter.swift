//
//  StoredAlbumsScenePresenter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

class StoredAlbumsScenePresenter {
    init(for view: StoredAlbumsSceneViewControllerType, service: StoredAlbumsScenePresenterServiceType) {
        self.viewController = view
        self.service = service
		
		service.getViewModel().shouldUpdateData.subscribe(self) { [unowned self] _ in
			viewController.update(viewModelDataType: .reloadData)
		}
    }
    
    private var viewController: StoredAlbumsSceneViewControllerType
    private var service: StoredAlbumsScenePresenterServiceType
}

extension StoredAlbumsScenePresenter: StoredAlbumsScenePresenterable {
    func response(responseType: StoredAlbumsScenePresenterResponse.StoredAlbumsSceneResponseType) {
        switch responseType {
		case .setupProvider: viewController.update(viewModelDataType: .setupProvider(with: service.getViewModel()))
		case .showMessage(let messageType):
			guard let messageViewViewModel = service.getMessageViewModel(for: messageType) else { return }
			
			viewController.update(viewModelDataType: .showMessage(withModel: messageViewViewModel))
        }
    }
}
