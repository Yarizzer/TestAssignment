//
//  LocationSceneViewControllerContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol LocationSceneViewControllerType {
    func update(viewModelDataType: LocationSceneViewControllerViewModel.ViewModelDataType)
}

struct LocationSceneViewControllerViewModel {
    enum ViewModelDataType {
        case initialSetup(with: LocationSceneViewModelType)
		case updateLocationData(with: LocationSceneViewModelType)
    }
}
