//
//  LocationSceneInteractorService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol LocationSceneInteractorServiceType {
	func switchLocationService()
}

class LocationSceneInteractorService {
    init(withModel model: LocationSceneViewModelType) {
        self.model = model
    }
    
    private var model: LocationSceneViewModelType
}

extension LocationSceneInteractorService: LocationSceneInteractorServiceType {
	func switchLocationService() {
		model.switchLocationService()
	}
}
