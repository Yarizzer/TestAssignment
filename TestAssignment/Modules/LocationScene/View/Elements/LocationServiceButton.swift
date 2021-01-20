//
//  LocationButton.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 18.01.2021.
//

import UIKit

enum LocationServiceButtonState {
	case enable
	case disable
}

class LocationServiceButton: UIButton {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layer.cornerRadius = frame.height / 2
		self.layer.masksToBounds = true
	}

	func setupState(with state: LocationServiceButtonState) {
		buttonState = state
	}
	
	func switchState() {
		guard let currentState = buttonState else { return }
		
		buttonState = (currentState == .enable) ? .disable : .enable
	}
	
	private var buttonState: LocationServiceButtonState? {
		didSet {
			guard let currentState = buttonState else { return }
			
			UIView.animate(withDuration: Constants.switchStateAnimationDuration / 2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) { [unowned self] in
				
				self.alpha = Constants.minAlphaValue
			} completion: { [unowned self] _ in
				switch currentState {
				case .enable:
					setBackgroundImage(UIImage(named: Constants.enableStateButtonImage), for: .normal)
					backgroundColor = .green
				case .disable:
					setBackgroundImage(UIImage(named: Constants.disableStateButtonImage), for: .normal)
					backgroundColor = .yellow
				}
				
				UIView.animate(withDuration: Constants.switchStateAnimationDuration / 2, delay: 0) {
					self.alpha = Constants.maxAlphaValue
				}
			}
		}
	}
}

extension LocationServiceButton {
	private struct Constants {
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		
		static let enableStateButtonImage = "EnableLocationButtonImage-universal"
		static let disableStateButtonImage = "DisableLocationButtonImage-universal"
		
		static let switchStateAnimationDuration: Double = 1
		
		//Animations
		static let firstBackgroundColor: UIColor = .red
		static let secondBackgroundColor: UIColor = .green
		static let backgroundColorAnimationKeyPath = "backgroundColor"
		static let keyTimes: [NSNumber] = [0.000, 0.300, 0.500, 0.800, 1.000]
		static let startMoment: Double = 0
		static let animationDuration: Double = 15
		static let timingFunctions = [CAMediaTimingFunction(name: .linear)]
		static let repeatCount: Float = HUGE
		static let removedOnCompletionFlag = false
	}
}
