//
//  SearchAlbumsSceneInteractorContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol SearchAlbumsSceneInteractorable {
    func makeRequest(requestType: SearchAlbumsSceneInteractorRequest.RequestType)
}

struct SearchAlbumsSceneInteractorRequest {
    enum RequestType {
        case setupProvider
		case routeToAlbumScene(withIndex: Int)
		case saveToLocalStorageAblum(withIndex: Int)
    }
}
