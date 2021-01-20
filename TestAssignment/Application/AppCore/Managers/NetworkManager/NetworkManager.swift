//
//  NetworkManager.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 15.01.2021.
//

import UIKit

protocol NetworkManageable {
	func fetchAlbums(completion: @escaping ([AlbumModel]) -> ())
	func fetchItemsForAlbum(with id: Int, completion: @escaping ([ItemModel]) ->())
	func fetchImageModelData(with url: String, completion: @escaping (ImageModel?) -> ())
}

class NetworkManager {
	private var imageCache = NSCache<NSString, UIImage>()
}

extension NetworkManager: NetworkManageable {
	func fetchAlbums(completion: @escaping ([AlbumModel]) -> ()) {
		guard let url = URL(string: AppConstants.albumsUrlString) else { return }
		
		var resultToReturn = [AlbumModel]()
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else { return }
			
			do {
				let result = try JSONDecoder().decode([AlbumModel].self, from: data)
				
				resultToReturn = result
			} catch {
				print(error.localizedDescription)
			}
			
			DispatchQueue.main.async { completion(resultToReturn) }
		}.resume()
	}
	
	func fetchItemsForAlbum(with id: Int, completion: @escaping ([ItemModel]) ->()){
		guard let url = URL(string: AppConstants.albumItemsUrlString + "\(id)") else { return }
		
		var resultToReturn = [ItemModel]()
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else { return }
			
			do {
				let result = try JSONDecoder().decode([ItemModel].self, from: data)
				
				resultToReturn = result
			} catch {
				print(error.localizedDescription)
			}
			
			DispatchQueue.main.async { completion(resultToReturn) }
		}.resume()
	}
	
	func fetchImageModelData(with url: String, completion: @escaping (ImageModel?) -> ()) {
		guard let url = URL(string: url) else { return }
		
		if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
			completion(ImageModel(url: url.absoluteString, imageData: cachedImage.pngData()))
		} else {
			let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
			URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard error == nil, let image = UIImage(data: data!), (response as? HTTPURLResponse)?.statusCode == 200 else {
					completion(nil)
					return
				}
				
				self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
				
				DispatchQueue.main.async { completion(ImageModel(url: url.absoluteString, imageData: image.pngData())) }
			}.resume()
		}
	}
}
