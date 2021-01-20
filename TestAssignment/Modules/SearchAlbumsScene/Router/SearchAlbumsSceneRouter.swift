//
//  SearchAlbumsSceneRouter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol SearchAlbumsSceneRouterable {
    static func assembly() -> UIViewController
	func routeToAlbumScene(with album: AlbumModel)
}

class SearchAlbumsSceneRouter {
    private weak var view: SearchAlbumsSceneViewController?
}

extension SearchAlbumsSceneRouter: SearchAlbumsSceneRouterable {
    static func assembly() -> UIViewController {
        let router = SearchAlbumsSceneRouter()
        let vc                  = SearchAlbumsSceneViewController(nibName: String(describing: SearchAlbumsSceneViewController.self), bundle: Bundle.main)
        let viewModel           = SearchAlbumsSceneViewModel()
        let presenterService    = SearchAlbumsScenePresenterService(withModel: viewModel)
        let presenter           = SearchAlbumsScenePresenter(for: vc, service: presenterService)
        let interactorService   = SearchAlbumsSceneInteractorService(withModel: viewModel)
        let interactor          = SearchAlbumsSceneInteractor(withRouter: router, presenter: presenter, service: interactorService)
        
        router.view = vc
        
        router.view?.interactor = interactor
        
        guard let view = router.view else {
            fatalError("cannot instantiate \(String(describing: SearchAlbumsSceneViewController.self))")
        }
        
        return view
    }
	
	func routeToAlbumScene(with album: AlbumModel) {
		let vc = AlbumSceneRouter.assembly(with: album)
		self.view?.present(vc, animated: true)
	}
}

