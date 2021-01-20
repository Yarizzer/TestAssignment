//
//  SearchAlbumsScenePresenter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

class SearchAlbumsScenePresenter {
    init(for view: SearchAlbumsSceneViewControllerType, service: SearchAlbumsScenePresenterServiceType) {
        self.viewController = view
        self.service = service
		
		service.getViewModel().shouldUpdateData.subscribe(self) { [unowned self] _ in
			viewController.update(viewModelDataType: .reloadData)
		}
    }
    
    private var viewController: SearchAlbumsSceneViewControllerType
    private var service: SearchAlbumsScenePresenterServiceType
}

extension SearchAlbumsScenePresenter: SearchAlbumsScenePresenterable {
    func response(responseType: SearchAlbumsScenePresenterResponse.SearchAlbumsSceneResponseType) {
        switch responseType {
		case .setupProvider: viewController.update(viewModelDataType: .setupProvider(with: service.getViewModel()))
		case .showMessage(let messageType):
			guard let messageViewViewModel = service.getMessageViewModel(for: messageType) else { return }
			
			viewController.update(viewModelDataType: .showMessage(withModel: messageViewViewModel))
        }
    }
}
