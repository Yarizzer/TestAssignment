//
//  ItemModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import Foundation

struct ItemModel: Decodable {
	
	init(with entity: ItemEntity) {
		self.albumId = Int(entity.albumID)
		self.id = Int(entity.id)
		self.title = entity.title
		self.url = entity.url
		self.thumbnailUrl = entity.thumbnailURL
		self.isLocal = true
	}
	
	let albumId: Int?
	let id: Int?
	let title: String?
	let url: String?
	let thumbnailUrl: String?
	var isLocal: Bool?
}
