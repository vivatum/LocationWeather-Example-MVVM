//
//  HistoryTableViewCell.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var weatherRecord: WeatherRecord? {
        didSet {
            populateCellContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.weatherRecord = nil
    }
    
    // MARK: - Cell content
    
    private func populateCellContent() {
        guard let record = self.weatherRecord else { return }
        DispatchQueue.main.async {
            self.dateLabel.text = record.date.toString(format: .longDateAndTime)
            self.locationLabel.text = record.coordinate().shortToString()
        }
    }
}
