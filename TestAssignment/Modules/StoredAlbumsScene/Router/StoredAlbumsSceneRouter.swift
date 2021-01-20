//
//  StoredAlbumsSceneRouter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol StoredAlbumsSceneRouterable {
    static func assembly() -> UIViewController
	func routeToAlbumScene(with album: AlbumModel)
}

class StoredAlbumsSceneRouter {
    private weak var view: StoredAlbumsSceneViewController?
}

extension StoredAlbumsSceneRouter: StoredAlbumsSceneRouterable {
    static func assembly() -> UIViewController {
        let router = StoredAlbumsSceneRouter()
        let vc                  = StoredAlbumsSceneViewController(nibName: String(describing: StoredAlbumsSceneViewController.self), bundle: Bundle.main)
        let viewModel           = StoredAlbumsSceneViewModel()
        let presenterService    = StoredAlbumsScenePresenterService(withModel: viewModel)
        let presenter           = StoredAlbumsScenePresenter(for: vc, service: presenterService)
        let interactorService   = StoredAlbumsSceneInteractorService(withModel: viewModel)
        let interactor          = StoredAlbumsSceneInteractor(withRouter: router, presenter: presenter, service: interactorService)
        
        router.view = vc
        
        router.view?.interactor = interactor
        
        guard let view = router.view else {
            fatalError("cannot instantiate \(String(describing: StoredAlbumsSceneViewController.self))")
        }
        
        return view
    }
	
	func routeToAlbumScene(with album: AlbumModel) {
		let vc = AlbumSceneRouter.assembly(with: album)
		self.view?.present(vc, animated: true)
	}
}
