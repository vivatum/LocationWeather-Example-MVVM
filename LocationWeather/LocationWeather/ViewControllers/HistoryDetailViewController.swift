//
//  HistoryDetailViewController.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit
import MapKit
import CocoaLumberjack

class HistoryDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    private let navTitle = "Record Details"
    private let dataSource = DetailDataSource()
    private let mapSpanDistance: CLLocationDegrees = 0.02
    
    var recordDetails: RecordDetails? {
        didSet {
            self.updateDetilsViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.navTitle
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self.dataSource
        self.tableView.tableFooterView = UIView()
    }
    
    private func updateDetilsViews() {
        guard let details = self.recordDetails else { return }
        
        DispatchQueue.main.async {
            
            self.dataSource.data = details
            self.tableView.reloadData()
            
            let annotation = RecordAnnotation(details: details)
            self.mapView.addAnnotation(annotation)

            var region = self.mapView.region
            region.center = annotation.coordinate
            region.span = MKCoordinateSpan(latitudeDelta: self.mapSpanDistance, longitudeDelta: self.mapSpanDistance)
            self.mapView.setRegion(region, animated: false)
        }
    }
    
}
