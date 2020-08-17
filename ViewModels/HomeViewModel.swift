//
//  HomeViewModel.swift
//  FirebaseNotifier
//
//  Created by Nevena Maksimovic on 8/12/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import Foundation
import FirebaseStorage

class HomeViewModel {
    
    private var scheduleItems = [ScheduleItem]()
    
    // MARK: - Schedule methods
    
    func loadItems(completion: @escaping (Result<Bool, NetworkError>) -> ()) {
        
        getFileUrl { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let url):
                
                NetworkManager.shared.downloadFile(from: url) { [weak self] result in
                
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let data):
                        if let items = XLSXReader.parseScheduleFile(data) {
                            
                            self.scheduleItems = items.sorted(by: { (item1, item2) -> Bool in
                                if let date1 = item1.dateFormatted, let date2 = item2.dateFormatted {
                                    return date1.compare(date2) == .orderedAscending
                                }
                                return true
                            })
                            completion(.success(true))
                        }
                        
                    case .failure(let error):
                        completion(.failure(.errorWithMessage(error.localizedDescription)))
                    }
                }
            case .failure(let error):
                completion(.failure(.errorWithMessage(error.localizedDescription)))
            }
        }
    }

    private func getFileUrl(completion: @escaping (Result<URL, NetworkError>) -> ()) {
        
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("ExcelFile.xlsx")
        
        fileRef.downloadURL { (URL, error) -> Void in
            
            // Success
            if let url = URL {
                completion(.success(url))
                
            // Error
            } else {
                if let error = error {
                    completion(.failure(.errorWithMessage(error.localizedDescription)))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func numberOfItems() -> Int {
        return scheduleItems.count
    }
    
    func sheduleItemForRow(at indexPath: IndexPath) -> ScheduleItem {
        
        return scheduleItems[indexPath.row]
    }
    
    func scheduleNotificationForItem(at indexPath: IndexPath, completion: (Bool, String?) -> ()) {
        
        let item = scheduleItems[indexPath.row]
        guard let date = item.dateFormatted else { return }
        
        if date < Date() {
            completion(false, nil)
            return
        }
        
        let dateWithTime = item.dateWithTime
        
        // Create notification
        LocalNotificationsManager.scheduleNotification(date: date, message: "Hello world!", identifier: dateWithTime)
        
        completion(true, dateWithTime)
    }
}
