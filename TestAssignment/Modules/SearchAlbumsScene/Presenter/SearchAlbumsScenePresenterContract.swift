//
//  SearchAlbumsScenePresenterContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol SearchAlbumsScenePresenterable {
    func response(responseType: SearchAlbumsScenePresenterResponse.SearchAlbumsSceneResponseType)
}

struct SearchAlbumsScenePresenterResponse {
    enum SearchAlbumsSceneResponseType {
        case setupProvider
		case showMessage(messageType: MessageViewType)
    }
}
