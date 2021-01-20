//
//  AlbumSceneCollectionViewCellViewModelType.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

import Foundation

protocol AlbumSceneCollectionViewCellViewModelType {
	func preparePublisher()
	
	var imageData: Publisher<Data?> { get }
	
	var itemTitle: String { get }
}

class AlbumSceneCollectionViewCellViewModel {
	init(with item: ItemModel) {
		self.item = item
	}
	
	func preparePublisher() {
		guard let url = (item.isLocal ?? false) ? item.url : item.thumbnailUrl else { return }
		
		AppCore.shared.getImage(with: url) { [weak self] in
			self?.imageData.value = $0?.imageData
		}
	}
	
	var imageData: Publisher<Data?> = Publisher(nil)
	
	private let item: ItemModel
}

extension AlbumSceneCollectionViewCellViewModel: AlbumSceneCollectionViewCellViewModelType {
	var itemTitle: String { return item.title ?? "" }
}
