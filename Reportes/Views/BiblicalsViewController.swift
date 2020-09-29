//
//  BiblicalsViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/23/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class BiblicalsViewController: UIViewController {
    
    var listBiblicals: [Biblical] = []

    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var lugarLabel: UILabel!
    
    @IBOutlet weak var biblicalsTableView: UITableView!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To hide the indicator at launch
        loadingIndicator.hidesWhenStopped = true
        self.biblicalsTableView.isHidden = false

        nombreLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.nombre)
        lugarLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.lugar)
        
        biblicalsTableView.dataSource = self
        biblicalsTableView.delegate = self
        
        biblicalsTableView.separatorStyle = .none
        biblicalsTableView.showsVerticalScrollIndicator = false
        
        self.loadingIndicator.startAnimating()
        
        // llamar al post request para recuperar los estudios
        let email = ManageUserData().getUserData(field: UserDefaults.Keys.email)
        let password = ManageUserData().getUserData(field: UserDefaults.Keys.password)
        
        let getBiblicalsRequest = APIGetBiblicalsRequest(email: email, password: password)
        
        getBiblicalsRequest.getBiblicals(completion: { result in
            switch result{
            case .success(let getBiblicalsResponse):
                guard let biblicals = getBiblicalsResponse.biblicals else {
                    return
                }
                self.listBiblicals = biblicals
                
                if(self.listBiblicals.count == 0){
                    DispatchQueue.main.async {
                    self.alertLabel.isHidden = false
                    self.biblicalsTableView.isHidden = true
                    self.alertLabel.text = "Todavía no ha creado ningún estudio bíblico"
                    }
                }else{
                    DispatchQueue.main.async {
                        self.biblicalsTableView.reloadData()
                        self.loadingIndicator.stopAnimating()
                        self.alertLabel.isHidden = true
                    }
                }
                
            case .failure(let error):
                print("Ocurrió un error \(error)")
                DispatchQueue.main.async {
                self.alertLabel.isHidden = false
                self.biblicalsTableView.isHidden = true
                self.alertLabel.text = "No se pudieron recuperar los reportes. Inténtelo denuevo"
                }
            }
        })
    }    


}

extension BiblicalsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBiblicals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = biblicalsTableView.dequeueReusableCell(withIdentifier: "biblicalCell") as! BiblicalTableViewCell
        let biblical = listBiblicals[indexPath.row]
        cell.nombreEstudioLabel.text = biblical.nombre
        cell.direccionLabel.text = biblical.direccion
        cell.monthLabel.text = MonthsShort[biblical.month]
        cell.yearLabel.text = String(biblical.year)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let biblical = listBiblicals[indexPath.row]
    }
}

