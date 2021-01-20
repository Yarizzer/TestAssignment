//
//  AudioPlayerServiceViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 18.01.2021.
//

import Foundation

protocol AudioPlayerServiceViewModelType {
	var url: URL { get }
}

class AudioPlayerServiceViewModel {
	init(with url: URL) {
		sourceUrl = url
	}
	
	private let sourceUrl: URL
}

extension AudioPlayerServiceViewModel: AudioPlayerServiceViewModelType {
	var url: URL { return sourceUrl }
}
