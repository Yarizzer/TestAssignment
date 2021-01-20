//
//  SearchAlbumsSceneViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol SearchAlbumsSceneViewModelType {
	var shouldUpdateData: Publisher<Bool?> { get }
	
	var saveToLocalStorageActionTitle: String { get }
	
	func getSearchAlbumsTableViewCellViewModelType(with index: Int) -> SearchAlbumsSceneTableViewCellViewModelType?
	func getAlbum(with index: Int) -> AlbumModel?
	func saveToLocalStorageAblum(with index: Int, completion: @escaping (Bool) -> ())
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType?
}

class SearchAlbumsSceneViewModel {
	init() {
		albums = AppCore.shared.remoteAlbumsData.value
		
		AppCore.shared.remoteAlbumsData.subscribe(self) { [unowned self] data in
			albums = data.newValue
		}
	}
	
	var shouldUpdateData: Publisher<Bool?> = Publisher(nil)
	
	private var albums: [AlbumModel]? {
		didSet {
			shouldUpdateData.value = true
		}
	}
}

extension SearchAlbumsSceneViewModel: SearchAlbumsSceneViewModelType {
	var saveToLocalStorageActionTitle: String { return Constants.saveToLocalStorageActionTitleValue }
	
	func getSearchAlbumsTableViewCellViewModelType(with index: Int) -> SearchAlbumsSceneTableViewCellViewModelType? {
		guard let album = albums?[index] else { return nil }
		
		return SearchAlbumsSceneTableViewCellViewModel(with: album)
	}
	
	func getAlbum(with index: Int) -> AlbumModel? {
		return albums?[index]
	}
	
	func saveToLocalStorageAblum(with index: Int, completion: @escaping (Bool) -> ()) {
		guard let album = albums?[index] else {
			completion(false)
			return
		}
		
		AppCore.shared.addToLocalStorage(album: album) { completion($0) }
	}
	
	func getMessageViewModel(for type: MessageViewType) -> MessageViewViewModelType? {
		switch type {
		case .info:
			let actions = [MessageViewActionModel(title: "Ok", actionType: .dismiss)]
			
			return MessageViewViewModel(with: (title: Constants.infoMessageDataValue.title, content: Constants.infoMessageDataValue.content, type: type, actions: actions))
		case .failure:
			let actions = [MessageViewActionModel(title: "Ok", actionType: .dismiss)]
			
			return MessageViewViewModel(with: (title: Constants.infoMessageDataValue.title, content: Constants.infoMessageDataValue.content, type: type, actions: actions))
		}
	}
}

extension SearchAlbumsSceneViewModel: TableViewProviderViewModel {
	func numberOfTableSections() -> Int {
		return Constants.numberOfSectionsValue
	}
	
	func numberOfTableRowsInSection(_ section: Int) -> Int {
		guard let albums = albums else { return 0 }
		
		return albums.count
	}
	
	func heightForRow(atIndex index: Int) -> Float {
		return Constants.rowHeightValue
	}
}

extension SearchAlbumsSceneViewModel {
	private struct Constants {
		static let numberOfSectionsValue = 1
		static let rowHeightValue: Float = 80
		
		static let saveToLocalStorageActionTitleValue = "Save to local storage"
		
		static let infoMessageDataValue = (title: "Success", content: "Album saved")
		static let failureMessageDataValue = (title: "Failure", content: "Error occured")
	}
}
