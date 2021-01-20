//
//  StoredAlbumsSceneInteractorContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol StoredAlbumsSceneInteractorable {
    func makeRequest(requestType: StoredAlbumsSceneInteractorRequest.RequestType)
}

struct StoredAlbumsSceneInteractorRequest {
    enum RequestType {
        case setupProvider
		case routeToAlbumScene(withIndex: Int)
		case setSlidedAlbum(withIndex: Int)
		case removeFromLocalStorageAlbum
    }
}
