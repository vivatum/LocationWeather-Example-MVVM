//
//  AlertHelperswift.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit
import CocoaLumberjack

public struct AlertHelper {
    
    static func showErrorAlert(_ alert: AlertMessage, action: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { alertAction -> Void in
            action?()
        }))
        
        guard let topViewController = UIApplication.topViewController() else {
            DDLogError("Can't get topViewController")
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = topViewController.view
        }
        
        DispatchQueue.main.async {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showPermissionLocationAlert(with message: String) {
        let title = "Location Service required"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: "Settings",
            style: .default,
            handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
        }))
        
        guard let topViewController = UIApplication.topViewController() else {
            DDLogError("Can't get topViewController")
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = topViewController.view
        }
        
        topViewController.present(alertController, animated: true, completion: nil)
    }
    
}


