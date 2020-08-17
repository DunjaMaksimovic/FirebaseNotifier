//
//  NetworkManager.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/11/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import Foundation

final class NetworkManager {
	
	static let shared = NetworkManager()
	
	init() { }
	
	func downloadFile(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> ()) {
		
		URLSession.shared.downloadTask(with: url) { localUrl, response, error in
			
            // Success
			if let localUrl = localUrl {
				if let data = try? Data(contentsOf: localUrl) {
					completion(.success(data))
				}
			}
            
            // Failure
            if let error = error {
                completion(.failure(.errorWithMessage(error.localizedDescription)))
            }
		}.resume()
	}
}
