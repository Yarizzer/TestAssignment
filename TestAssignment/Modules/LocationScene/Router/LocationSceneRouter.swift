//
//  LocationSceneRouter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol LocationSceneRouterable {
    static func assembly() -> UIViewController
}

class LocationSceneRouter {
    private weak var view: LocationSceneViewController?
}

extension LocationSceneRouter: LocationSceneRouterable {
    static func assembly() -> UIViewController {
        let router = LocationSceneRouter()
        let vc                  = LocationSceneViewController(nibName: String(describing: LocationSceneViewController.self), bundle: Bundle.main)
        let viewModel           = LocationSceneViewModel()
        let presenterService    = LocationScenePresenterService(withModel: viewModel)
        let presenter           = LocationScenePresenter(for: vc, service: presenterService)
        let interactorService   = LocationSceneInteractorService(withModel: viewModel)
        let interactor          = LocationSceneInteractor(withRouter: router, presenter: presenter, service: interactorService)
        
        router.view = vc
        
        router.view?.interactor = interactor
        
        guard let view = router.view else {
            fatalError("cannot instantiate \(String(describing: LocationSceneViewController.self))")
        }
        
        return view
    }
}

