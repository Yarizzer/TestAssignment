//
//  AlbumSceneInteractor.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

class AlbumSceneInteractor {
    init(withRouter router: AlbumSceneRouterable, presenter: AlbumScenePresenterable, service: AlbumSceneInteractorServiceType) {
        self.router = router
        self.presenter = presenter
        self.service = service
    }

    private var router: AlbumSceneRouterable
    private var presenter: AlbumScenePresenterable
    private var service: AlbumSceneInteractorServiceType
}

extension AlbumSceneInteractor: AlbumSceneInteractorable {
    func makeRequest(requestType: AlbumSceneInteractorRequest.RequestType) {
        switch requestType {
        case .initialSetup:
			presenter.response(responseType: .initialSetup)
			service.changeSelectedItemWithItem(at: 0)       //Setting up: selected item - first item
		case .changeSelectedItemWithItemAt(let index): service.changeSelectedItemWithItem(at: index)
		case .addToLocalStorageAlbum:
			service.addToLocalStorageAlbum() { [unowned self] in
				if !$0 {
					presenter.response(responseType: .showMessageView(withType: .failure(content: nil)))
				}
			}
		case .removeFromLocalStorageAlbum:
			service.removeFromLocalStorageAlbum() { [unowned self] in
				if $0 {
					self.router.dismiss()
				}
			}
		case .askConfirmation: presenter.response(responseType: .showMessageView(withType: .info(content: nil)))
        }
    }
}
