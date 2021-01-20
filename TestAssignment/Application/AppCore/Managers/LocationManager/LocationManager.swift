//
//  LocationManager.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 18.01.2021.
//

import CoreLocation

enum LocationMonitoringState {
	case enable
	case disable
}

protocol LocationManageable {
	func setup()
	func runSession()
	
	var coordinates: Publisher<(latitude: String, longitude: String)?> { get }
	var serviceIsEnable: Bool { get }
	func switchMonitoringState(completion: ((Bool) -> ())?)
}

class LocationManager: NSObject {
	func setup() {
		locationManager.delegate = self
	}
	
	func runSession() {
		locationManager.requestAlwaysAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		locationManager.allowsBackgroundLocationUpdates = Constants.allowsBackgroundLocationUpdatesValue
		locationManager.pausesLocationUpdatesAutomatically = Constants.pausesLocationUpdatesAutomaticallyValue
		
		switch locationManager.authorizationStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			state = UserDefaults.standard.bool(forKey: AppConstants.UserDefaults.locationIsEnableKey.rawValue) ? .enable : .disable
		case .restricted, .denied, .notDetermined: state = .disable
		@unknown default:
			print("unknown status")
		}
	}
	
	var coordinates: Publisher<(latitude: String, longitude: String)?> = Publisher(nil)
	
	private let locationManager = CLLocationManager()
	private var state: LocationMonitoringState? {
		didSet {
			if state == .enable {
				locationManager.startUpdatingLocation()
			} else {
				locationManager.stopUpdatingLocation()
				coordinates.value = (latitude: "service is disabled", longitude: "service is disabled")
			}
		}
	}
}

extension LocationManager: LocationManageable {
	var serviceIsEnable: Bool {
		return state == .enable
	}
	
	func switchMonitoringState(completion: ((Bool) -> ())? = nil) {
		state = (state == .enable) ? .disable : .enable
		
		UserDefaults.standard.set( state == .enable, forKey: AppConstants.UserDefaults.locationIsEnableKey.rawValue)
		
		completion?(state == .enable)
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = manager.location?.coordinate else { return }
		
		coordinates.value = (latitude: location.latitude.description, longitude: location.longitude.description)
	}
}

extension LocationManager {
	private struct Constants {
		static let allowsBackgroundLocationUpdatesValue = true
		static let pausesLocationUpdatesAutomaticallyValue = false
	}
}
