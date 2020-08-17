//
//  XLSXReader.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/12/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import Foundation
import CoreXLSX

final class XLSXReader {
	
	static func parseScheduleFile(_ data: Data) -> [ScheduleItem]? {
		
		do {
			let file = try XLSXFile(data: data)
			
			for workBook in try file.parseWorkbooks() {
				for (_, path) in try file.parseWorksheetPathsAndNames(workbook: workBook) {
					
					let worksheet = try file.parseWorksheet(at: path)
					let sharedStrings = try file.parseSharedStrings()
					
					guard let rows = worksheet.data?.rows else { return nil }
					
					var scheduleItems = [ScheduleItem]()
					
					for (rowIndex, row) in rows.enumerated() {
						for (cellIndex, cell) in row.cells.enumerated() {
							
							guard rowIndex > 0 && cellIndex > 0 else { continue }
							guard let timeString = cell.stringValue(sharedStrings) else { continue }
							
							let dateString = row.cells.first?.stringValue(sharedStrings)
							let title = rows.first?.cells[cellIndex].stringValue(sharedStrings)
							
							// Add if date&time is unique
							if !scheduleItems.contains(where: { $0.dateString == dateString && $0.timeString == timeString }) {
								let item = ScheduleItem(title: title, dateString: dateString, timeString: timeString)
								scheduleItems.append(item)
							}
						}
					}
					return scheduleItems
				}
			}
		} catch {
            return nil
		}
		
		return nil
	}
}
