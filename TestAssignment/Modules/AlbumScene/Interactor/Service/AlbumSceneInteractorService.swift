//
//  AlbumSceneInteractorService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

protocol AlbumSceneInteractorServiceType {
	func changeSelectedItemWithItem(at index: Int)
	func addToLocalStorageAlbum(completion: @escaping (Bool) -> ())
	func removeFromLocalStorageAlbum(completion: @escaping (Bool) -> ())
}

class AlbumSceneInteractorService {
    init(withModel model: AlbumSceneViewModelType) {
        self.model = model
    }
    
    private var model: AlbumSceneViewModelType
}

extension AlbumSceneInteractorService: AlbumSceneInteractorServiceType {
	func changeSelectedItemWithItem(at index: Int) { model.changeSelectedItemWithItem(at: index) }
	
	func addToLocalStorageAlbum(completion: @escaping (Bool) -> ()) {
		model.addToLocalStorageAlbum() {
			completion($0)
		}
	}
	
	func removeFromLocalStorageAlbum(completion: @escaping (Bool) -> ()) {
		model.removeFromLocalStorageAlbum() {
			completion($0)
		}
	}
}
