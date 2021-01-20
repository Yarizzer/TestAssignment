//
//  SearchAlbumsSceneViewControllerContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol SearchAlbumsSceneViewControllerType {
    func update(viewModelDataType: SearchAlbumsSceneViewControllerViewModel.ViewModelDataType)
}

struct SearchAlbumsSceneViewControllerViewModel {
    enum ViewModelDataType {
		case setupProvider(with: SearchAlbumsSceneViewModelType)
		case reloadData
		case showMessage(withModel: MessageViewViewModelType)
    }
}
