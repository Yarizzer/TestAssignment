//
//  SearchAlbumsSceneInteractorService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol SearchAlbumsSceneInteractorServiceType {
	func getAlbum(withIndex index: Int) -> AlbumModel?
	func saveToLocalStorageAblum(with index: Int, completion: @escaping (Bool) -> ())
}

class SearchAlbumsSceneInteractorService {
    init(withModel model: SearchAlbumsSceneViewModelType) {
        self.model = model
    }
    
    private var model: SearchAlbumsSceneViewModelType
}

extension SearchAlbumsSceneInteractorService: SearchAlbumsSceneInteractorServiceType {
	func getAlbum(withIndex index: Int) -> AlbumModel? { return model.getAlbum(with: index) }
	
	func saveToLocalStorageAblum(with index: Int, completion: @escaping (Bool) -> ()) {
		model.saveToLocalStorageAblum(with: index) { completion($0) }
	}
}
