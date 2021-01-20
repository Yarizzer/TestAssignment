//
//  StoredAlbumsSceneTableViewCellViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 17.01.2021.
//

import Foundation

protocol StoredAlbumsSceneTableViewCellViewModelType {
	var userID: String { get }
	var albumID: String { get }
	var albumTitle: String { get }
}

class StoredAlbumsSceneTableViewCellViewModel {
	init(with album: AlbumModel) {
		self.album = album
	}
	
	private let album: AlbumModel
}

extension StoredAlbumsSceneTableViewCellViewModel: StoredAlbumsSceneTableViewCellViewModelType {
	var userID: String {
		guard let id = album.userId else { return "" }
		
		return "User id: \(id)"
	}
	
	var albumID: String {
		guard let id = album.id else { return "" }
		
		return "Album id: \(id)"
	}
	
	var albumTitle: String { return album.title ?? "" }
}
