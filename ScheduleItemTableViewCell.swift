//
//  ScheduleItemTableViewCell.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/12/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import UIKit

final class ScheduleItemTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Properties
    
    var item: ScheduleItem?
	
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
		
    }
	
	func config(with item: ScheduleItem?) {
        
        titleLabel.text = item?.title
        dateLabel.text = item?.dateWithTime
	}
}
