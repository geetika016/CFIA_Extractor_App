//
//  HistoryVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var history_listView: UITableView!
    var historysortData = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.title = "Search History"
        self.history_listView.delegate = self
        self.history_listView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.ResortData()
    }
    func ResortData(){
        self.historysortData = NSMutableArray()
        let timestamp = Int(NSDate().timeIntervalSince1970) as! Int
        for index in 0..<AppData.shared.historyData.count {
            let each_data = AppData.shared.historyData[index] as! NSDictionary
            let timestamp1 = each_data["timestamp"] as! Int
            let time_interval = (timestamp - timestamp1) / 3600
            if (time_interval <= 24) {
                self.historysortData.add(each_data)
            }
            
        }
        self.history_listView.reloadData()
    }

}
extension HistoryVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historysortData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        let cellData = self.historysortData[indexPath.row] as! NSDictionary
        let real_data = cellData["product"] as! NSDictionary
        let imageurl6 = real_data["image_url"] as! String
        let prodcut_namestr = real_data["product_name"] as! String
        let product_amountstr = real_data["quantity"] as! String
        let product_brandsstr = real_data["brands"] as! String
        cell.product_imaeg.moa.url = imageurl6
        cell.product_amount.text = product_amountstr
        cell.product_name.text = product_brandsstr
        cell.product_label.text = prodcut_namestr
        
        
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width:
            tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = .groupTableViewBackground
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 5, width:
            tableView.bounds.size.width - 30, height: 20))
        headerLabel.textColor = .black
        headerLabel.text = "Last 24 hours"
        headerLabel.textAlignment = .left
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width:
            tableView.bounds.size.width, height: 40))
        let footerLabel = UILabel(frame: CGRect(x: 15, y: 10, width:
            tableView.bounds.size.width - 30, height: 20))
        footerLabel.textColor = .lightGray
        footerLabel.textAlignment = .center
        footerLabel.text = "Your search history is only stored on your device"
        footerLabel.numberOfLines = 2
        footerView.addSubview(footerLabel)
        
        return footerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "historydetailVC") as! HistoryDetailVC
        let cellData = self.historysortData[indexPath.row] as! NSDictionary
        let real_data = cellData["product"] as! NSDictionary
        vc.historyData = real_data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
