//
//  DatabaseManager.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit
import CoreData

protocol DatabaseManageable {
	//ImageEntities
	func getImageModelData(withURL url: String) -> ImageModel?
	func addNewImage(withModel model: ImageModel)
	func removeImageEntities()
	//Storad albums
	func add(new album: AlbumModel, with items: [ItemModel], completion: @escaping (AlbumModel) -> ())
	func removeAlbum(with id: Int, completion: (Bool) -> ())
	func getAlbums(completion: @escaping ([AlbumModel]) -> ())
}

class DatabaseManager {
	init() {
		let delegate = UIApplication.shared.delegate as! AppDelegate
		self.context = delegate.persistentContainer.viewContext
		
		albumsFetchRequest = AlbumEntity.fetchRequest()
		itemsFetchRequest = ItemEntity.fetchRequest()
	}
	
	//MARK: - Context
	private func saveContext() {
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private let context: NSManagedObjectContext
	private let albumsFetchRequest: NSFetchRequest<AlbumEntity>
	private let itemsFetchRequest: NSFetchRequest<ItemEntity>
}

extension DatabaseManager: DatabaseManageable {
	func getImageModelData(withURL url: String) -> ImageModel? {
		let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "url == %@", url)
		
		var valueToReturn: ImageModel?
		do {
			let result = try context.fetch(fetchRequest)
			
			guard let imageEntity = result.first else { return nil }
			
			valueToReturn = ImageModel(url: imageEntity.url, imageData: imageEntity.imageData)
		} catch {
			print(error.localizedDescription)
		}
		
		return valueToReturn
	}
	
	func addNewImage(withModel model: ImageModel) {
		let entity = NSEntityDescription.entity(forEntityName: "ImageEntity", in: context)
		let entityObject = NSManagedObject(entity: entity!, insertInto: context) as! ImageEntity

		entityObject.url = model.url
		entityObject.imageData = model.imageData
		
		saveContext()
	}
	
	func removeImageEntities() {
		getAlbums { [unowned self] in
			var activeURLs = [String]()
			
			$0.forEach { album in
				album.items?.forEach { item in
					guard let url = item.url else { return }
					
					activeURLs.append(url)
				}
			}
			
			let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "NOT (url IN %@)", activeURLs)
			
			do {
				let result = try context.fetch(fetchRequest)
				result.forEach { item in
					context.delete(item)
				}
				
				try context.save()
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	//Storad albums
	func add(new album: AlbumModel, with items: [ItemModel], completion: @escaping (AlbumModel) -> ()) {
		guard let userID = album.userId,
			  let id = album.id,
			  let albumEntity = NSEntityDescription.entity(forEntityName: "AlbumEntity", in: context) else { return }
		
		let albumObject = NSManagedObject(entity: albumEntity, insertInto: context) as! AlbumEntity
		albumObject.userID = Int16(userID)
		albumObject.id = Int16(id)
		albumObject.title = album.title
		
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
		
		items.forEach { itemData in
			guard let albumID = itemData.albumId,
				  let id = itemData.id,
				  let itemEntity = NSEntityDescription.entity(forEntityName: "ItemEntity", in: context) else { return }
		
			let itemObject = NSManagedObject(entity: itemEntity, insertInto: context) as! ItemEntity
			itemObject.albumID = Int16(albumID)
			itemObject.id = Int16(id)
			itemObject.title = itemData.title
			itemObject.url = itemData.url
			itemObject.thumbnailURL = itemData.thumbnailUrl
			itemObject.albumEntityRelation = albumObject
			
			do {
				try context.save()
			} catch {
				print(error.localizedDescription)
			}
		}
		
		completion(AlbumModel(with: albumObject))
	}
	
	func removeAlbum(with id: Int, completion: (Bool) -> ()) {
		let albumsFetchRequest: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()
		let itemsFetchRequest: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
		
		albumsFetchRequest.predicate = NSPredicate(format: "id = \(id)")
		itemsFetchRequest.predicate = NSPredicate(format: "albumEntityRelation.id = \(id)")
		
		do {
			try context.fetch(itemsFetchRequest).forEach { context.delete($0) }
			try context.fetch(albumsFetchRequest).forEach { context.delete($0) }
			try context.save()
			
			completion(true)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func getAlbums(completion: @escaping ([AlbumModel]) -> ()) {
		let albumsFetchRequest: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()
		
		var resultToReturn = [AlbumModel]()
		
		do {
			let result = try context.fetch(albumsFetchRequest)
			result.forEach { resultToReturn.append(AlbumModel(with: $0))}
		} catch {
			print(error.localizedDescription)
		}
		
		completion(resultToReturn)
	}
}
