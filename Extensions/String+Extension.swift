//
//  String+Extension.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/12/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import Foundation

extension String {
	
	func date() -> Date? {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
		
		dateFormatter.timeZone = TimeZone.autoupdatingCurrent
		let date = dateFormatter.date(from: self)
		
		return date
	}
}
