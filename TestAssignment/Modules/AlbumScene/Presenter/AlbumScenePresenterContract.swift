//
//  AlbumScenePresenterContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

protocol AlbumScenePresenterable {
    func response(responseType: AlbumScenePresenterResponse.AlbumSceneResponseType)
}

struct AlbumScenePresenterResponse {
    enum AlbumSceneResponseType {
        case initialSetup
		case showMessageView(withType: MessageViewType)
    }
}
