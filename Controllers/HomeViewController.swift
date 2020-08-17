//
//  HomeViewController.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/11/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
	
    // MARK: - Outlets
    
	@IBOutlet weak var tableView: UITableView!
	
    // MARK: - Properties
    
    private var homeViewModel = HomeViewModel()
    
    // MARK: - View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
        setup()
        
        homeViewModel.loadItems() { [weak self] result in
        
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success:
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    self.showAlert(title: "Error occured", message: error.localizedDescription)
                }
                
            }
        }
	}
    
    // MARK: - Setup
	
	private func setup() {
		
		tableView.register(UINib(nibName: ScheduleItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ScheduleItemTableViewCell.identifier)
		tableView.delegate = self
		tableView.dataSource = self
	}
}

// MARK: - Table view

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
        return homeViewModel.numberOfItems()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleItemTableViewCell.identifier, for: indexPath) as! ScheduleItemTableViewCell
		
        cell.config(with: homeViewModel.sheduleItemForRow(at: indexPath))
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
        homeViewModel.scheduleNotificationForItem(at: indexPath) { (success, dateWithTime) in
            DispatchQueue.main.async {
                
                if success {
                    self.showAlert(title: "Great", message: "You will be notified at \(dateWithTime ?? "selected time")")
                } else {
                    self.showAlert(title: "Whoops", message: "You can not notify your past self")
                }
            }
        }
	}
}
