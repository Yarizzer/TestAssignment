//
//  AlbumSceneInteractorContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

protocol AlbumSceneInteractorable {
    func makeRequest(requestType: AlbumSceneInteractorRequest.RequestType)
}

struct AlbumSceneInteractorRequest {
    enum RequestType {
        case initialSetup
		case changeSelectedItemWithItemAt(index: Int)
		case addToLocalStorageAlbum
		case removeFromLocalStorageAlbum
		case askConfirmation
    }
}
