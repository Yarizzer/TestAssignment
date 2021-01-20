//
//  SearchAlbumsScenePresenterService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol SearchAlbumsScenePresenterServiceType {
    func getViewModel() -> SearchAlbumsSceneViewModelType
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType?
}

class SearchAlbumsScenePresenterService {
    init(withModel model: SearchAlbumsSceneViewModelType) {
        self.model = model
    }
    
    private var model: SearchAlbumsSceneViewModelType
}

extension SearchAlbumsScenePresenterService: SearchAlbumsScenePresenterServiceType {
	func getViewModel() -> SearchAlbumsSceneViewModelType { return model }
	
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType? {
		return model.getMessageViewModel(for: type)
	}
}
