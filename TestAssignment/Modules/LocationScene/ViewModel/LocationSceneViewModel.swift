//
//  LocationSceneViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import Foundation

protocol LocationSceneViewModelType {
	func setupSubscription()
	
	var locaionDidUpdate: Publisher<Bool?> { get }
	
	var locationServiceIsEnable: Bool { get }
	var latitude: String { get }
	var longitude: String { get }
	
	func switchLocationService()
	func getAudioPlayerServiceViewModel() -> AudioPlayerServiceViewModelType
}

class LocationSceneViewModel {
	init() {
		self.location = AppCore.shared.locationData.value ?? (latitude: "", longitude: "")
	}
	
	func setupSubscription() {
		location = AppCore.shared.locationData.value
		AppCore.shared.locationData.subscribe(self) { [unowned self] data in
			guard let value = data.newValue else { return }
			
			location = value
		}
	}
	
	private var location: (latitude: String, longitude: String)? {
		didSet {
			locaionDidUpdate.value = true
		}
	}
	
	var locaionDidUpdate: Publisher<Bool?> = Publisher(nil)
}

extension LocationSceneViewModel: LocationSceneViewModelType {
	var locationServiceIsEnable: Bool { return AppCore.shared.serviceIsEnable }
	var latitude: String { return location?.latitude ?? Constants.dataPlaceholder }
	var longitude: String { return location?.longitude ?? Constants.dataPlaceholder }
	
	func switchLocationService() {
		AppCore.shared.switchMonitoringState { [unowned self] in
			locaionDidUpdate.value = $0
		}
	}
	
	func getAudioPlayerServiceViewModel() -> AudioPlayerServiceViewModelType {
		return AudioPlayerServiceViewModel(with: Bundle.main.url(forResource: Constants.soundFileName, withExtension: Constants.extent)!)
	}
}

extension LocationSceneViewModel {
	private struct Constants {
		static let dataPlaceholder = "no data"
		static let speechServiceTextValue = "Location serice enabled"
		static let soundFileName = "I Gotsta Get Paid"
		static let extent = "m4a"
	}
}
