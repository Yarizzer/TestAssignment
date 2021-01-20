//
//  AlbumSceneViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 16.01.2021.
//

import Foundation

protocol AlbumSceneViewModelType {
	var previewImageData: Publisher<Data?> { get }
	var shouldUpdateDate: Publisher<Bool?> { get }
	var didChangedSelectedItem: Publisher<Bool?> { get }
	var albumIsInLocalStore: Publisher<Bool?> { get }
	
	var sceneTitle: String { get }
	
	func getCollectionViewCellViewModel(for index: Int) -> AlbumSceneCollectionViewCellViewModelType?
	func changeSelectedItemWithItem(at index: Int)
	func addToLocalStorageAlbum(completion: @escaping (Bool) -> ())
	func removeFromLocalStorageAlbum(completion: @escaping (Bool) -> ())
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType
}

class AlbumSceneViewModel {
	init(with album: AlbumModel) {
		self.album = album
		
		guard let id = album.id else { return }
		
		albumIsInLocalStore.value = album.isLocal ?? false
		
		if albumIsInLocalStore.value == true {
			albumItems = album.items
		} else {
			AppCore.shared.getItemsForAlbum(with: id) { [weak self] in
				self?.albumItems = $0
			}
		}
	}
	
	private func updateImagePreview(with url: String?) {
		if let imageUrl = url {
			AppCore.shared.getImage(with: imageUrl) { data in
				self.previewImageData.value = data?.imageData
			}
		}
	}
	
	private func updateAlbumItems() {
		if (albumIsInLocalStore.value ?? false) ? true : false {
			guard let id = album.id, let localAlbum = AppCore.shared.localAlbumsData.value?.filter({ $0.id != id }).first else { return }
			
			album = localAlbum
			albumItems = localAlbum.items
		} else {
			guard let id = album.id else { return }
			
			AppCore.shared.getItemsForAlbum(with: id) { [weak self] in
				self?.albumItems = $0
			}
		}
	}
	
	private var album: AlbumModel
	private var albumItems: [ItemModel]? {
		didSet {
			shouldUpdateDate.value = true
			selectedItem = albumItems?.first
		}
	}
	
	private var selectedItem: ItemModel? {
		didSet {
			didChangedSelectedItem.value = true
			updateImagePreview(with: selectedItem?.url)
		}
	}
	
	var previewImageData: Publisher<Data?> = Publisher(nil)
	var shouldUpdateDate: Publisher<Bool?> = Publisher(nil)
	var didChangedSelectedItem: Publisher<Bool?> = Publisher(nil)
	var albumIsInLocalStore: Publisher<Bool?> = Publisher(nil)
}

extension AlbumSceneViewModel: AlbumSceneViewModelType {
	var sceneTitle: String { return album.title ?? "" }
	
	func changeSelectedItemWithItem(at index: Int) {
		guard let newItem = albumItems?[index] else { return }

		selectedItem = newItem
	}
	
	func getCollectionViewCellViewModel(for index: Int) -> AlbumSceneCollectionViewCellViewModelType? {
		guard let item = albumItems?[index] else { return nil }
		
		return AlbumSceneCollectionViewCellViewModel(with: item)
	}
	
	func addToLocalStorageAlbum(completion: @escaping (Bool) -> ()) {
		AppCore.shared.addToLocalStorage(album: album) { [unowned self] success in
			if success {
				self.albumIsInLocalStore.value = true
				updateAlbumItems()
			}
			
			completion(success)
		}
	}
	
	func removeFromLocalStorageAlbum(completion: @escaping (Bool) -> ()) {
		AppCore.shared.removeFromStorage(album: album) {
			completion($0)
		}
	}
	
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType {
		switch type {
		case .info(content: let content):
			let actions = [MessageViewActionModel(title: "Confirm", actionType: .confirm),
						   MessageViewActionModel(title: "Dismiss", actionType: .dismiss)]
			
			return MessageViewViewModel(with: (title: Constants.infoMessageDataValue.title, content: content ?? Constants.infoMessageDataValue.content, type: .info(content: nil), actions: actions))
		case .failure(content: let content):
			let actions = [MessageViewActionModel(title: "Ok", actionType: .dismiss)]
			
			return MessageViewViewModel(with: (title: Constants.failureMessageDataValue.title, content: content ?? Constants.failureMessageDataValue.content, type: .info(content: nil), actions: actions))
		}
		
	}
}

extension AlbumSceneViewModel: CollectionViewProviderViewModel {
	func numberOfItemsIn(section: Int) -> Int {
		guard let count = albumItems?.count else { return 0 }
		
		return count
	}
}

extension AlbumSceneViewModel {
	private struct Constants {
		static let infoMessageDataValue = (title: "Are you sure?", content: "Cofirmation will remove album from local storage")
		static let failureMessageDataValue = (title: "Something went wrong", content: "It might be album is already persist in local storage. Check out 'Stored albums' tab.")
	}
}
