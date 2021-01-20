//
//  AppCore.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

//import Foundation

class AppCore {
	static let shared = AppCore()
	
	private init() {
		self.networkManager = NetworkManager()
		self.databaseManager = DatabaseManager()
		self.locationManager = LocationManager()
		self.styleManager = StyleManager()
		self.deviceManager = DeviceManager()
	}
	
	//MARK: - Session
	func runSession() {
		networkManager.fetchAlbums { [unowned self] in
			remoteAlbumsData.value = $0
		}
		
		databaseManager.getAlbums { [unowned self] in
			localAlbumsData.value = $0
		}
		
		locationManager.coordinates.subscribe(self) { [unowned self] data in
			locationData.value = data.newValue
		}
		
		locationManager.setup()
		locationManager.runSession()
	}
	
	func closeSession() { databaseManager.removeImageEntities() }
	
	//MARK: - Data
	var remoteAlbumsData: Publisher<[AlbumModel]?> = Publisher(nil)
	var localAlbumsData: Publisher<[AlbumModel]?> = Publisher(nil)
	var locationData: Publisher<(latitude: String, longitude: String)?> = Publisher(nil)
	
	//MARK: - Managers
	private let networkManager: NetworkManageable
	private let databaseManager: DatabaseManageable
	private let locationManager: LocationManageable
	private let styleManager: StyleManageable
	private let deviceManager: DeviceManageable
	
	func getImage(with url: String, completion: @escaping (ImageModel?) -> ()) {
		if let imageModel = databaseManager.getImageModelData(withURL: url) {
			completion(imageModel)
		} else {
			networkManager.fetchImageModelData(with: url) { [unowned self] data in
				guard let data = data else { return }
				
				databaseManager.addNewImage(withModel: data)
				completion(data)
			}
		}
	}
}

extension AppCore: AppNetworkManageable {
	func getItemsForAlbum(with id: Int, completion: @escaping ([ItemModel]) -> ()) {
		guard (remoteAlbumsData.value?.filter({ $0.id == id}).first) != nil else { return }
		
		networkManager.fetchItemsForAlbum(with: id) { completion($0) }
	}
}

extension AppCore: AppDatabaseManageable {
	func addToLocalStorage(album: AlbumModel, completion: @escaping (Bool) -> ()) {
		guard let id = album.id, let localData = localAlbumsData.value?.filter({ $0.id == id }), localData.isEmpty else {
			
			completion(false)
			return
		}
		
		getItemsForAlbum(with: id) { [unowned self] items in
			items.forEach {
				guard let url = $0.url else { return }
				
				getImage(with: url) { print("Image \($0.debugDescription) saved") }
			}
			
			self.databaseManager.add(new: album, with: items) { [unowned self] in
				localAlbumsData.value?.append($0)
				completion(true)
			}
		}
	}
	
	func removeFromStorage(album: AlbumModel, completion: @escaping(Bool) -> ()) {
		guard let id = album.id, let localData = localAlbumsData.value?.filter({ $0.id == id }), !localData.isEmpty else { return }
		
		databaseManager.removeAlbum(with: id) { [unowned self] finished in
			if finished {
				localAlbumsData.value = localAlbumsData.value?.filter { $0.id != id }
				completion(finished)
			}
		}
	}
}

extension AppCore: AppLocationManageable {
	var serviceIsEnable: Bool { return locationManager.serviceIsEnable }
	func switchMonitoringState(completion: @escaping(Bool) -> ()) {
		locationManager.switchMonitoringState() { completion($0) }
	}
}

extension AppCore: AppStyleManageable {
	var appStyleManager: StyleManageable { return styleManager }
}

extension AppCore: AppDeviceManageable {
	var appDeviceManager: DeviceManageable { return deviceManager }
}
