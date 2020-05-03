//
//  HistoryDataSource.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit
import RealmSwift

final class HistoryDataSource: NSObject, UITableViewDataSource {
    
    public var data: Dynamic<Results<WeatherRecord>?> = Dynamic(nil)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.weatherRecord = data.value?[indexPath.row]
        return cell
    }
}
