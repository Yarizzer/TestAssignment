//
//  SaveDeleteButton.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 17.01.2021.
//

import UIKit

enum SaveDeleteButtonState {
	case save
	case delete
}

class SaveDeleteButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		animateBackgroundColor()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		animateBackgroundColor()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layer.cornerRadius = frame.height / 2
		self.layer.masksToBounds = true
	}
	
	func setupState(with state: SaveDeleteButtonState) {
		buttonState = state
	}
	
	private func animateBackgroundColor() {
		let backgroundColorAnimation = CAKeyframeAnimation(keyPath: Constants.backgroundColorAnimationKeyPath)
		backgroundColorAnimation.duration = Constants.animationDuration
		backgroundColorAnimation.values = [Constants.firstBackgroundColor.cgColor,
										   Constants.firstBackgroundColor.cgColor,
										   Constants.secondBackgroundColor.cgColor,
										   Constants.secondBackgroundColor.cgColor,
										   Constants.firstBackgroundColor.cgColor]
		backgroundColorAnimation.keyTimes = Constants.keyTimes
		backgroundColorAnimation.timingFunctions = Constants.timingFunctions
		backgroundColorAnimation.repeatCount = Constants.repeatCount
		backgroundColorAnimation.beginTime = Constants.startMoment
		backgroundColorAnimation.isRemovedOnCompletion = Constants.removedOnCompletionFlag
		self.layer.add(backgroundColorAnimation, forKey: Constants.backgroundColorAnimationKeyPath)
	}
	
	private var buttonState: SaveDeleteButtonState? {
		didSet {
			guard let currentState = buttonState else { return }
			
			UIView.animate(withDuration: Constants.switchStateAnimationDuration / 2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) { [unowned self] in
				
				self.alpha = Constants.minAlphaValue
			} completion: { [unowned self] _ in
				switch currentState {
				case .save: setBackgroundImage(UIImage(named: Constants.saveStateButtonImage), for: .normal)
				case .delete: setBackgroundImage(UIImage(named: Constants.deleteStateButtonImage), for: .normal)
				}
				
				UIView.animate(withDuration: Constants.switchStateAnimationDuration / 2, delay: 0) {
					self.alpha = Constants.maxAlphaValue
				}
			}
		}
	}
	
	var currentState: SaveDeleteButtonState? { return buttonState }
}

extension SaveDeleteButton {
	private struct Constants {
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		
		static let saveStateButtonImage = "AddToLocalStorageButtonImage-universal"
		static let deleteStateButtonImage = "RemoveFromLocalStorageButtonImage-universal"
		
		static let switchStateAnimationDuration: Double = 1
		
		//Animations
		static let firstBackgroundColor: UIColor = .red
		static let secondBackgroundColor: UIColor = .orange
		static let backgroundColorAnimationKeyPath = "backgroundColor"
		static let keyTimes: [NSNumber] = [0.000, 0.300, 0.500, 0.800, 1.000]
		static let startMoment: Double = 0
		static let animationDuration: Double = 15
		static let timingFunctions = [CAMediaTimingFunction(name: .linear)]
		static let repeatCount: Float = HUGE
		static let removedOnCompletionFlag = false
	}
}
