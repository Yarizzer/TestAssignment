//
//  StoredAlbumsSceneInteractor.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

class StoredAlbumsSceneInteractor {
    init(withRouter router: StoredAlbumsSceneRouterable, presenter: StoredAlbumsScenePresenterable, service: StoredAlbumsSceneInteractorServiceType) {
        self.router = router
        self.presenter = presenter
        self.service = service
    }

    private var router: StoredAlbumsSceneRouterable
    private var presenter: StoredAlbumsScenePresenterable
    private var service: StoredAlbumsSceneInteractorServiceType
}

extension StoredAlbumsSceneInteractor: StoredAlbumsSceneInteractorable {
    func makeRequest(requestType: StoredAlbumsSceneInteractorRequest.RequestType) {
        switch requestType {
		case .setupProvider: presenter.response(responseType: .setupProvider)
		case .routeToAlbumScene(let index):
			guard let album = service.getAlbum(withIndex: index) else { return }
			
			router.routeToAlbumScene(with: album)
		case .setSlidedAlbum(let index):
			service.setSlidedAlbum(with: index)
			presenter.response(responseType: .showMessage(withType: .info(content: nil)))
		case .removeFromLocalStorageAlbum:
			service.removeFromLocalStorageAlbum()
        }
    }
}
