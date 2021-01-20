//
//  AudioPlayerService.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 18.01.2021.
//

import AVKit

protocol AudioPlayerServiceType {
	func play()
	func stop()
}

class AudioPlayerService {
	func setup(with model: AudioPlayerServiceViewModelType) {
		
		playerItem = AVPlayerItem(url: model.url)
		player.replaceCurrentItem(with: playerItem)
	}
	
	private var playerItem: AVPlayerItem?
	private let player = AVPlayer()
}

extension AudioPlayerService: AudioPlayerServiceType {
	func play() {
		player.play()
	}
	
	func stop() {
		player.pause()
		player.seek(to: CMTime.zero)
	}
}
