//
//  StoredAlbumsScenePresenterService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol StoredAlbumsScenePresenterServiceType {
    func getViewModel() -> StoredAlbumsSceneViewModelType
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType?
}

class StoredAlbumsScenePresenterService {
    init(withModel model: StoredAlbumsSceneViewModelType) {
        self.model = model
    }
    
    private var model: StoredAlbumsSceneViewModelType
}

extension StoredAlbumsScenePresenterService: StoredAlbumsScenePresenterServiceType {
	func getViewModel() -> StoredAlbumsSceneViewModelType { return model }
	
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType? {
		return model.getMessageViewModel(for: type)
	}
}
