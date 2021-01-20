//
//  LocationSceneInteractor.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

class LocationSceneInteractor {
    init(withRouter router: LocationSceneRouterable, presenter: LocationScenePresenterable, service: LocationSceneInteractorServiceType) {
        self.router = router
        self.presenter = presenter
        self.service = service
    }

    private var router: LocationSceneRouterable
    private var presenter: LocationScenePresenterable
    private var service: LocationSceneInteractorServiceType
}

extension LocationSceneInteractor: LocationSceneInteractorable {
    func makeRequest(requestType: LocationSceneInteractorRequest.RequestType) {
        switch requestType {
		case .initialSetup: presenter.response(responseType: .initialSetup)
		case .switchLocationService: service.switchLocationService()
        }
    }
}
