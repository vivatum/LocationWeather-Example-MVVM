//
//  LocationHistoryViewController.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit
import CocoaLumberjack

final class LocationHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private enum Segue: String {
        case details = "ShowDetailSegue"
    }
    
    private let navTitle = "History"
    private var noDataView: NoDataView?
        
    let dataSource = HistoryDataSource()
    
    lazy var viewModel: HistoryViewModel = {
        return HistoryViewModel(dataSource: dataSource)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = navTitle
        self.setupViewModel()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.noDataView = NoDataView()
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
        self.tableView.backgroundView = self.noDataView
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - NoDataView Message
    
    private func updtateNoDataMessage(_ isDataEmpty: Bool?) {
        self.noDataView?.message = (isDataEmpty ?? true) ? .noDataFetched : .noMessage
    }
    
    // MARK: - Setup ViewModel
    
    private func setupViewModel() {
        
        self.dataSource.data.bindAndFire { [weak self] data in
            DispatchQueue.main.async {
                self?.updtateNoDataMessage(data?.isEmpty)
                self?.tableView.reloadData()
            }
        }

        self.viewModel.onErrorHandling = { [weak self] error in
            DDLogError("Error: \(String(describing: error?.localizedDescription))")
            DispatchQueue.main.async {
                if let err = error {
                   AlertHelper.showErrorAlert(err.alertContent)
                }
                if let viewData = self?.dataSource.data.value {
                    self?.updtateNoDataMessage(viewData.isEmpty)
                }
            }
        }

        self.viewModel.showRecordDetails = { [weak self] details in
            DDLogInfo("Show contact details")
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: Segue.details.rawValue, sender: details)
            }
        }
    }
    
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.details.rawValue {
            
            guard let details = sender as? RecordDetails else {
                DDLogError("Can't get RecordDetails from sender")
                return
            }
            
            if let controller = segue.destination as? HistoryDetailViewController {
                controller.recordDetails = details
                DDLogInfo("Go to HistoryDetailViewController")
            }
        }
    }
}

extension LocationHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            self.viewModel.selectedIndexPath = indexPath
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
