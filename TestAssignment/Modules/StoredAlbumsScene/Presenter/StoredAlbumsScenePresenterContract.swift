//
//  StoredAlbumsScenePresenterContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol StoredAlbumsScenePresenterable {
    func response(responseType: StoredAlbumsScenePresenterResponse.StoredAlbumsSceneResponseType)
}

struct StoredAlbumsScenePresenterResponse {
    enum StoredAlbumsSceneResponseType {
        case setupProvider
		case showMessage(withType: MessageViewType)
    }
}
