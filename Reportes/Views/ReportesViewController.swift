//
//  ReportesViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/12/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class ReportesViewController: UIViewController {
    
    var listReportes: [Report] = []

    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var lugarLabel: UILabel!    
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var reportsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To hide the indicator at launch
        loadingIndicator.hidesWhenStopped = true
        self.reportsTableView.isHidden = false
        

        nombreLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.nombre)
        lugarLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.lugar)
        
        reportsTableView.dataSource = self
        reportsTableView.delegate = self
        
        reportsTableView.separatorStyle = .none
        reportsTableView.showsVerticalScrollIndicator = false
        
        self.loadingIndicator.startAnimating()
        
        // llamar al post request para recuperar los reportes
        let email = ManageUserData().getUserData(field: UserDefaults.Keys.email)
        let password = ManageUserData().getUserData(field: UserDefaults.Keys.password)
        
        let getReportsRequest = APIGetReportsRequest(email: email, password: password)
        
        getReportsRequest.getReports(completion: { result in
            switch result{
            case .success(let getReportsResponse):
                guard let reportes = getReportsResponse.reports else {
                    return
                }
                self.listReportes = reportes
                
                if(self.listReportes.count == 0){
                    DispatchQueue.main.async {
                    self.alertLabel.isHidden = false
                    self.reportsTableView.isHidden = true
                    self.alertLabel.text = "Todavía no ha creado ningún reporte"
                    }
                }else{
                    DispatchQueue.main.async {
                        self.reportsTableView.reloadData()
                        self.loadingIndicator.stopAnimating()
                        self.alertLabel.isHidden = true
                    }
                }
                
            case .failure(let error):
                print("Ocurrió un error \(error)")
                DispatchQueue.main.async {
                self.alertLabel.isHidden = false
                self.reportsTableView.isHidden = true
                self.alertLabel.text = "No se pudieron recuperar los reportes. Inténtelo denuevo"
                }
            }
        })
    }

}

extension ReportesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listReportes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reportsTableView.dequeueReusableCell(withIdentifier: "reportCell") as! ReportTableViewCell
        let report = listReportes[indexPath.row]
        cell.ayunosLabel.text = "Ayunos: " + String(report.ayunos)
        cell.avivamientosLabel.text = "Avivamientos: " + String(report.avivamientos)
        cell.fechaLabel.text = Months[report.month] ?? "" + "-" + String(report.year)
        cell.visitasLabel.text = "Visitas: " + String(report.visitas)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let report = listReportes[indexPath.row]
        
        // ir al otro viewcontroler
        let reportVC = self.storyboard?.instantiateViewController(identifier: "reportVC") as! ReportViewController
        
        // Enviar datos al proximo viewcontroller
        reportVC.report = report
        
        reportVC.modalPresentationStyle = .fullScreen
        self.present(reportVC, animated: true)
    }
}
