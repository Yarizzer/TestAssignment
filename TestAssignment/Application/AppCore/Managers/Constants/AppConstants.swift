//
//  AppConstants.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

struct AppConstants {
	//Network
	static let albumsUrlString = "https://jsonplaceholder.typicode.com/albums"
	static let albumItemsUrlString = "https://jsonplaceholder.typicode.com/photos?albumId="
	
	enum UserDefaults: String {
		case locationIsEnableKey = "locationIsEnable"
	}
}
