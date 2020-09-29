//
//  BiblicalTableViewCell.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/23/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class BiblicalTableViewCell: UITableViewCell {

    @IBOutlet weak var direccionLabel: UILabel!
    
    @IBOutlet weak var nombreEstudioLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
