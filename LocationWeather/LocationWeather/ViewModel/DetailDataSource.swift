//
//  DetailDataSource.swift
//  LocationWeather
//
//  Created by Vivatum on 01/05/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

final class DetailDataSource: NSObject, UITableViewDataSource {
    
    var data: RecordDetails?
    
    private enum DetailTitle: String {
        case Time = "Time"
        case Location = "Location"
        case Description = "Weather Description"
        case Temperature = "Daily MAX temperature"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = DetailTitle.Time.rawValue
            cell.contentLabel.text = data?.dataString
        case 1:
            cell.titleLabel.text = DetailTitle.Location.rawValue
            cell.contentLabel.text = data?.coordinate().longToString(true)
        case 2:
            cell.titleLabel.text = DetailTitle.Description.rawValue
            cell.contentLabel.text = data?.description
        case 3:
            cell.titleLabel.text = DetailTitle.Temperature.rawValue
            cell.contentLabel.text = data?.temperatureDalyMax
        default:
            return UITableViewCell()
        }
        
        return cell
    }
}
