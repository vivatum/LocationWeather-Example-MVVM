//
//  HistoryViewModel.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import CocoaLumberjack
import RealmSwift

final class HistoryViewModel {
    
    weak var dataSource: HistoryDataSource?
    
    private var recordList: Results<WeatherRecord>?
    private var notificationToken: NotificationToken? = nil
    
    var showRecordDetails: ((RecordDetails) -> Void)?
    var onErrorHandling: ((ActionError?) -> Void)?
    
    var selectedIndexPath: IndexPath? {
        didSet {
            if let selectedRecord = getRecordByIndexPath(selectedIndexPath),
                let details = getRecordDetails(selectedRecord) {
                self.showRecordDetails?(details)
            }
        }
    }
    
    init(dataSource: HistoryDataSource?) {
        self.dataSource = dataSource
        
        self.setupRealmCollection()
        self.setupRealmNotification()
    }
    
    
    // MARK: - MAX temperature for selected Day
    
    private func getRecordByIndexPath(_ selectedIndexPath: IndexPath?) -> WeatherRecord? {
        
        guard let indexPath = selectedIndexPath else {
            let errorMessage = "Can't get selected IndexPath"
            DDLogError(errorMessage)
            self.onErrorHandling?(.custom(errorMessage))
            return nil
        }
        
        guard let tableData = self.dataSource?.data.value else {
            let errorMessage = "Can't get tableData"
            DDLogError(errorMessage)
            self.onErrorHandling?(.custom(errorMessage))
            return nil
        }
        
        return tableData[indexPath.row]
    }
    
    private func getRecordDetails(_ selectedRecord: WeatherRecord) -> RecordDetails? {
        guard let history = self.recordList else { return nil }
        var details: RecordDetails? = nil
        
        let calendar = Calendar.current
        let predicateLocation = NSPredicate(format: "latitude == %f AND longitude == %f", selectedRecord.latitude, selectedRecord.longitude)
        
        if let dailyMaxTempRecord = history
            .filter(predicateLocation)
            .filter({calendar.isDate($0.date, inSameDayAs: selectedRecord.date)})
            .sorted(by: { $0.temperatureMax > $1.temperatureMax })
            .first {
            
            details = RecordDetails(weatherRecord: selectedRecord, maxTemperature: dailyMaxTempRecord.temperatureMax)
        }
        
        return details
    }
    
    // MARK: - Realm methods
    
    private func setupRealmCollection() {
        do {
            let realm = try Realm()
            self.recordList = realm.objects(WeatherRecord.self)
            DDLogInfo("WeatherRecord collection fetched: \(String(describing: self.recordList?.count))")
        }
        catch let error {
            DDLogError("Can't fetch WeatherRecord collection: \(error.localizedDescription)")
        }
    }
    
    private func setupRealmNotification() {
        notificationToken = recordList?.observe { (changes: RealmCollectionChange) in
            DDLogInfo("Realm notification received")
            if let history = self.recordList {
                self.dataSource?.data.value = history.sorted(byKeyPath: "date", ascending: false)
            }
        }
    }
    
    // MARK: - Deinit
    
    deinit {
        self.notificationToken?.invalidate()
    }
}
