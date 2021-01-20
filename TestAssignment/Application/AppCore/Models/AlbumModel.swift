//
//  AlbumModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

struct AlbumModel: Decodable {
	
	init(with entity: AlbumEntity) {
		self.userId = Int(entity.userID)
		self.id = Int(entity.id)
		self.title = entity.title
		self.isLocal = true
		
		self.items = [ItemModel]()
		
		entity.itemEntityRelation?.forEach {
			guard let itemEntity = $0 as? ItemEntity else { return }
			
			self.items?.append(ItemModel(with: itemEntity))
		}
	}
	
	let userId: Int?
	let id: Int?
	let title: String?
	var items: [ItemModel]?
	var isLocal: Bool?
}
