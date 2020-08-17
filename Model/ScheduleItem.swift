//
//  ScheduleItem.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/12/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import Foundation

struct ScheduleItem {
	
	let title: String?
	let dateString: String?
	let timeString: String?
    
    var dateWithTime: String? {
        
        guard var dateString = dateString, var timeString = timeString else { return nil }
        
        let month = dateString.components(separatedBy: "/").first
        if month?.count == 1{
            dateString = "0" + dateString
        }
        
        let hours = timeString.components(separatedBy: ":").first
        if hours?.count == 1 {
            timeString = "0" + timeString
        }
        
        return dateString + " " + timeString
        
    }
    
    var dateFormatted: Date? {
        dateWithTime?.date()
    }
}
