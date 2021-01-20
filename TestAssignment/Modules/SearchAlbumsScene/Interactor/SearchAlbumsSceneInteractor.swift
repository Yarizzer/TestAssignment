//
//  SearchAlbumsSceneInteractor.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

class SearchAlbumsSceneInteractor {
    init(withRouter router: SearchAlbumsSceneRouterable, presenter: SearchAlbumsScenePresenterable, service: SearchAlbumsSceneInteractorServiceType) {
        self.router = router
        self.presenter = presenter
        self.service = service
    }

    private var router: SearchAlbumsSceneRouterable
    private var presenter: SearchAlbumsScenePresenterable
    private var service: SearchAlbumsSceneInteractorServiceType
}

extension SearchAlbumsSceneInteractor: SearchAlbumsSceneInteractorable {
    func makeRequest(requestType: SearchAlbumsSceneInteractorRequest.RequestType) {
        switch requestType {
		case .setupProvider: presenter.response(responseType: .setupProvider)
		case .routeToAlbumScene(let index):
			guard let album = service.getAlbum(withIndex: index) else { return }
			
			router.routeToAlbumScene(with: album)
		case .saveToLocalStorageAblum(let index):
			service.saveToLocalStorageAblum(with: index) { [unowned self] in
				presenter.response(responseType: .showMessage(messageType: $0 ? .info(content: nil) : .failure(content: nil)))
			}
        }
    }
}
