//
//  StoredAlbumsSceneViewControllerContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol StoredAlbumsSceneViewControllerType {
    func update(viewModelDataType: StoredAlbumsSceneViewControllerViewModel.ViewModelDataType)
}

struct StoredAlbumsSceneViewControllerViewModel {
    enum ViewModelDataType {
        case setupProvider(with: StoredAlbumsSceneViewModelType)
		case reloadData
		case showMessage(withModel: MessageViewViewModelType)
    }
}
