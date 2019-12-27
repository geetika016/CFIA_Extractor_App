//
//  OverViewCell.swift
//  Extractor
//
//  Created by Jin Omori on 12/1/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class OverViewCell: UITableViewCell {

    
    @IBOutlet weak var key_name: UILabel!
    
    @IBOutlet weak var key_value: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
