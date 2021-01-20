//
//  LocationScenePresenter.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class LocationScenePresenter {
    init(for view: LocationSceneViewControllerType, service: LocationScenePresenterServiceType) {
        self.viewController = view
        self.service = service
		
		service.getViewModel().locaionDidUpdate.subscribe(self) { [unowned self] data in
			viewController.update(viewModelDataType: .updateLocationData(with: service.getViewModel()))
		}
    }
    
    private var viewController: LocationSceneViewControllerType
    private var service: LocationScenePresenterServiceType
}

extension LocationScenePresenter: LocationScenePresenterable {
    func response(responseType: LocationScenePresenterResponse.LocationSceneResponseType) {
        switch responseType {
		case .initialSetup:
			let model = service.getViewModel()
			
			viewController.update(viewModelDataType: .initialSetup(with: model))
			model.setupSubscription()
        }
    }
}
