//
//  ReportViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/15/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var lugarLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    
    // Para recibir los datos del reporte desde el tableview del historial de reportes
    var report: Report?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lugarLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.lugar)
        nombreLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.nombre)
        
        if let actualReport = report {
            var month = actualReport.month
            if month<0 || month>12{
                month = 0
            }
            fechaLabel.text = "\(actualReport.day)/\(Months[month] ?? "")/\(actualReport.year)"
        }else{
            print("El reporte esta vacío o esta")
        }
        
    }
    
    
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
