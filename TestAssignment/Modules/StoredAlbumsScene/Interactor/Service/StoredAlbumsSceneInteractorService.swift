//
//  StoredAlbumsSceneInteractorService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol StoredAlbumsSceneInteractorServiceType {
	func getAlbum(withIndex index: Int) -> AlbumModel?
	func setSlidedAlbum(with index: Int)
	func removeFromLocalStorageAlbum()
}

class StoredAlbumsSceneInteractorService {
    init(withModel model: StoredAlbumsSceneViewModelType) {
        self.model = model
    }
    
    private var model: StoredAlbumsSceneViewModelType
}

extension StoredAlbumsSceneInteractorService: StoredAlbumsSceneInteractorServiceType {
	func getAlbum(withIndex index: Int) -> AlbumModel? { return model.getAlbum(with: index) }
	
	func setSlidedAlbum(with index: Int) { model.setSlidedAlbum(with: index) }
	
	func removeFromLocalStorageAlbum() { model.removeFromLocalStorageAlbum() }
}
