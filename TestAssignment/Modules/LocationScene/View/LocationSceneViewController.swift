//
//  LocationSceneViewController.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

class LocationSceneViewController: BaseViewController<LocationSceneInteractorable> {
    // MARK: View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
	}
	
	private func setupView() {
		interactor?.makeRequest(requestType: .initialSetup)
	}
	
	@IBAction private func locationButtonAction(_ sender: LocationServiceButton) {
		interactor?.makeRequest(requestType: .switchLocationService)
		AppCore.shared.appDeviceManager.generateSuccessFeedback()
		sender.switchState()
	}
	
	private var audioPlayerService: AudioPlayerServiceType?
	@IBOutlet private weak var locationLabel: UILabel!
	@IBOutlet private weak var locationButton: LocationServiceButton!
}

extension LocationSceneViewController: LocationSceneViewControllerType {
    func update(viewModelDataType: LocationSceneViewControllerViewModel.ViewModelDataType) {
        switch viewModelDataType {
		case .initialSetup(let model):
			locationButton.setupState(with: model.locationServiceIsEnable ? .disable : .enable)
			
			audioPlayerService = AudioPlayerService()
			(audioPlayerService as? AudioPlayerService)?.setup(with: model.getAudioPlayerServiceViewModel())
		case .updateLocationData(let model):
			locationLabel.text = model.latitude + " - " + model.longitude
			if model.locationServiceIsEnable {
				audioPlayerService?.play()
			} else {
				audioPlayerService?.stop()
			}
        }
    }
}
