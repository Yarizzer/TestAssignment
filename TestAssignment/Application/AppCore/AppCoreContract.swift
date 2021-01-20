//
//  AppCoreContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

protocol AppNetworkManageable {
	func getItemsForAlbum(with id: Int, completion: @escaping ([ItemModel]) -> ())
}

protocol AppDatabaseManageable {
	func addToLocalStorage(album: AlbumModel, completion: @escaping (Bool) -> ())
	func removeFromStorage(album: AlbumModel, completion: @escaping(Bool) -> ())
}

protocol AppLocationManageable {
	var serviceIsEnable: Bool { get }
	func switchMonitoringState(completion: @escaping(Bool) -> ())
}

protocol AppStyleManageable {
	var appStyleManager: StyleManageable { get }
}

protocol AppDeviceManageable {
	var appDeviceManager: DeviceManageable { get }
}
