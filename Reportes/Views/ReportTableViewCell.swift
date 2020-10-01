//
//  ReportTableViewCell.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/13/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var reportView: UIView!
    
    @IBOutlet weak var ayunosLabel: UILabel!
    
    @IBOutlet weak var avivamientosLabel: UILabel!
    
    @IBOutlet weak var fechaLabel: UILabel!
    
    @IBOutlet weak var visitasLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
