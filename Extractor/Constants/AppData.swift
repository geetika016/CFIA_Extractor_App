//
//  AppData.swift
//  Extractor
//
//  Created by Jin Omori on 12/1/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import Foundation
import MBProgressHUD
class AppData {
    static let shared: AppData = {
        return AppData()
    }()
    var loadingNotification: MBProgressHUD!
    func showLoadingIndicator(view: UIView){
        loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.bezelView.color = UIColor.red
        loadingNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        loadingNotification.label.text = "Loading..."
        loadingNotification.label.textColor = .white
        
    }
    
    func hideLoadingIndicator(){
        loadingNotification.hide(animated: true)
    }
    var historyData = NSMutableArray()
    
    
}
