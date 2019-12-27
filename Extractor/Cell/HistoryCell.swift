//
//  HistoryCell.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    
    @IBOutlet weak var product_imaeg: UIImageView!
    @IBOutlet weak var product_label: UILabel!
    @IBOutlet weak var product_name: UILabel!
    @IBOutlet weak var product_amount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
