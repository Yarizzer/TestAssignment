//
//  SearchAlbumsSceneTableViewCellViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import Foundation

protocol SearchAlbumsSceneTableViewCellViewModelType {
	var userID: String { get }
	var albumID: String { get }
	var albumTitle: String { get }
}

class SearchAlbumsSceneTableViewCellViewModel {
	init(with album: AlbumModel) {
		self.album = album
	}
	
	private let album: AlbumModel
}

extension SearchAlbumsSceneTableViewCellViewModel: SearchAlbumsSceneTableViewCellViewModelType {
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
