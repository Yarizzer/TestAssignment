//
//  LocationScenePresenterContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol LocationScenePresenterable {
    func response(responseType: LocationScenePresenterResponse.LocationSceneResponseType)
}

struct LocationScenePresenterResponse {
    enum LocationSceneResponseType {
        case initialSetup
    }
}
