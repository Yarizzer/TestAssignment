//
//  AlbumSceneViewControllerContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

import Foundation

protocol AlbumSceneViewControllerType {
    func update(viewModelDataType: AlbumSceneViewControllerViewModel.ViewModelDataType)
}

struct AlbumSceneViewControllerViewModel {
    enum ViewModelDataType {
        case initialSetup(with: AlbumSceneViewModelType)
		case setupProvider(with: AlbumSceneViewModelType)
		case reloadData
		case updatePreviewImage(with: Data?)
		case didChangedSelectedImage
		case showMessage(withModel: MessageViewViewModelType)
    }
}
