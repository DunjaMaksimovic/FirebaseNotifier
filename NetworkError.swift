//
//  NetworkError.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/11/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	
	case errorWithMessage(_ message: String)
	case unknownError
    
    var message: String {
        
        switch self {
        case .errorWithMessage(let message):
            return message
        default:
            return "Unknown error, try again later"
        }
    }
}
