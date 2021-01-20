//
//  LocationSceneInteractorContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol LocationSceneInteractorable {
    func makeRequest(requestType: LocationSceneInteractorRequest.RequestType)
}

struct LocationSceneInteractorRequest {
    enum RequestType {
        case initialSetup
		case switchLocationService
    }
}
