//
//  StoredAlbumsSceneViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol StoredAlbumsSceneViewModelType {
	var shouldUpdateData: Publisher<Bool?> { get }
	
	var removeFromLocalStorageActionTitle: String { get }
	
	func getStoredAlbumsTableViewCellViewModelType(with index: Int) -> StoredAlbumsSceneTableViewCellViewModelType?
	func getAlbum(with index: Int) -> AlbumModel?
	func setSlidedAlbum(with index: Int)
	func removeFromLocalStorageAlbum()
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType?
}

class StoredAlbumsSceneViewModel {
	init() {
		albums = AppCore.shared.localAlbumsData.value
		
		AppCore.shared.localAlbumsData.subscribe(self) { [unowned self] data in
			self.albums = data.newValue
		}
	}
	
	var shouldUpdateData: Publisher<Bool?> = Publisher(nil)
	
	private var albums: [AlbumModel]? {
		didSet {
			shouldUpdateData.value = true
		}
	}
	
	private var selectedAlbumIndex: Int?
}

extension StoredAlbumsSceneViewModel: StoredAlbumsSceneViewModelType {
	var removeFromLocalStorageActionTitle: String { return Constants.removeFromLocalStorageActionTitleValue }
	
	func getStoredAlbumsTableViewCellViewModelType(with index: Int) -> StoredAlbumsSceneTableViewCellViewModelType? {
		guard let album = albums?[index] else { return nil }
		
		return StoredAlbumsSceneTableViewCellViewModel(with: album)
	}
	
	func getAlbum(with index: Int) -> AlbumModel? { return albums?[index] }
	
	func setSlidedAlbum(with index: Int) {
		selectedAlbumIndex = index
	}
	
	func removeFromLocalStorageAlbum() {
		guard let index = selectedAlbumIndex, let album = albums?[index] else { return }
		
		AppCore.shared.removeFromStorage(album: album) { print($0) }
	}
	
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType? {
		switch type {
		case .info:
			let actions = [MessageViewActionModel(title: "Confirm", actionType: .confirm),
						   MessageViewActionModel(title: "Dismiss", actionType: .dismiss)]
			
			return MessageViewViewModel(with: (title: Constants.infoMessageDataValue.title, content: Constants.infoMessageDataValue.content, type: type, actions: actions))
		case .failure: return nil
		}
	}
}

extension StoredAlbumsSceneViewModel: TableViewProviderViewModel {
	func numberOfTableSections() -> Int {
		return Constants.numberOfSectionsValue
	}
	
	func numberOfTableRowsInSection(_ section: Int) -> Int {
		guard let albums = albums else { return 0 }
		
		return albums.count
	}
	
	func heightForRow(atIndex index: Int) -> Float { return Constants.rowHeightValue }
}

extension StoredAlbumsSceneViewModel {
	private struct Constants {
		static let numberOfSectionsValue = 1
		static let rowHeightValue: Float = 80
		
		static let removeFromLocalStorageActionTitleValue = "Delete"
		
		static let infoMessageDataValue = (title: "Are you sure?", content: "Cofirmation will remove album from local storage")
	}
}
