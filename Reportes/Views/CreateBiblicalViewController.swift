//
//  CreateBiblicalViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/21/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class CreateBiblicalViewController: UIViewController {

    @IBOutlet weak var lugarLabel: UILabel!
    
    @IBOutlet weak var fechaLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nombreEstudioTextField: FloatingLabelInput!
    
    @IBOutlet weak var direccionTextField: FloatingLabelInput!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To hide the indicator at launch
        loadingIndicator.hidesWhenStopped = true

        lugarLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.lugar)
        nameLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.nombre)
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        fechaLabel.text = String(day) + "/" + String(month) + "/" + String(year)
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }    

    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDidTap(_ sender: Any) {
        let email = ManageUserData().getUserData(field: UserDefaults.Keys.email)
        let password = ManageUserData().getUserData(field: UserDefaults.Keys.password)
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        var biblicalData = Biblical(year: year, month: month, day: day, nombre: "",direccion: "", email: email, password: password)
        
        biblicalData.nombre = String(nombreEstudioTextField.text ?? "SCC")
        biblicalData.direccion = String(direccionTextField.text ?? "SCC")
                
        self.loadingIndicator.startAnimating()
        
        // llamar al post request para agregar el reporte
        let postNewBiblicalRequest = APINewBiblicalRequest()
        
        postNewBiblicalRequest.newBiblical(biblicalData, completion: { result in
            switch result{
            case .success(let newBiblicalResponse):
                print("Se ha agregado el Estudio Bíblico satisfactoriamente: \(String(describing: newBiblicalResponse.biblical))")
                                
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    // ir al historial de estudios biblicos
                    let mainTB = self.storyboard?.instantiateViewController(identifier: "mainTapBar") as! MainTabBarController
                    mainTB.modalPresentationStyle = .fullScreen
                    mainTB.selectedIndex = 2
                    self.present(mainTB, animated: true)
                }
            case .failure(let error):
                print("Ocurrió un error \(error)")
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                }
            }
        })
    }
    
}
