//
//  AlbumSceneRouter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

import UIKit

protocol AlbumSceneRouterable {
	static func assembly(with album: AlbumModel) -> UIViewController
	func dismiss()
}

class AlbumSceneRouter {
    private weak var view: AlbumSceneViewController?
}

extension AlbumSceneRouter: AlbumSceneRouterable {
    static func assembly(with album: AlbumModel) -> UIViewController {
        let router = AlbumSceneRouter()
        let vc                  = AlbumSceneViewController(nibName: String(describing: AlbumSceneViewController.self), bundle: Bundle.main)
        let viewModel           = AlbumSceneViewModel(with: album)
        let presenterService    = AlbumScenePresenterService(withModel: viewModel)
        let presenter           = AlbumScenePresenter(for: vc, service: presenterService)
        let interactorService   = AlbumSceneInteractorService(withModel: viewModel)
        let interactor          = AlbumSceneInteractor(withRouter: router, presenter: presenter, service: interactorService)
        
        router.view = vc
        
        router.view?.interactor = interactor
        
        guard let view = router.view else {
            fatalError("cannot instantiate \(String(describing: AlbumSceneViewController.self))")
        }
        
        return view
    }
	
	func dismiss() {
		view?.dismiss(animated: true)
	}
}
