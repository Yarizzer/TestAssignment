//
//  AlbumScenePresenterService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

import UIKit

protocol AlbumScenePresenterServiceType {
	func getViewModel() -> AlbumSceneViewModelType
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType
}

class AlbumScenePresenterService {
    init(withModel model: AlbumSceneViewModelType) {
        self.model = model
    }
    
    private var model: AlbumSceneViewModelType
}

extension AlbumScenePresenterService: AlbumScenePresenterServiceType {
	func getViewModel() -> AlbumSceneViewModelType { return model }
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType {
		return model.getMessageViewModel(for: type)
	}
}
