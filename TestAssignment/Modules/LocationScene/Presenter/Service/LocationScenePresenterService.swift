//
//  LocationScenePresenterService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol LocationScenePresenterServiceType {
    func getViewModel() -> LocationSceneViewModelType
}

class LocationScenePresenterService {
    init(withModel model: LocationSceneViewModelType) {
        self.model = model
    }
    
    private var model: LocationSceneViewModelType
}

extension LocationScenePresenterService: LocationScenePresenterServiceType {
	func getViewModel() -> LocationSceneViewModelType {
		return model
	}
}
