//
//  CreateReportViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 8/29/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class CreateReportViewController: UIViewController {

    @IBOutlet weak var lugarLabel: UILabel!
    
    @IBOutlet weak var fechaLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var avivamientosTextView: FloatingLabelInput!
    
    @IBOutlet weak var bibliasTextView: FloatingLabelInput!
    
    @IBOutlet weak var ayunosTextView: FloatingLabelInput!
    
    @IBOutlet weak var horasAyunosTextView: FloatingLabelInput!
    
    @IBOutlet weak var cultosTextView: FloatingLabelInput!
    
    @IBOutlet weak var devocionalesTextView: FloatingLabelInput!
    
    @IBOutlet weak var enfermosTextView: FloatingLabelInput!
    
    @IBOutlet weak var hogaresTextView: FloatingLabelInput!
    
    @IBOutlet weak var asistidosTextField: FloatingLabelInput!
    
    @IBOutlet weak var establecidosTextField: FloatingLabelInput!
    
    @IBOutlet weak var realizadosTextField: FloatingLabelInput!
    
    @IBOutlet weak var mensajerosTextField: FloatingLabelInput!
    
    @IBOutlet weak var porcionesTextField: FloatingLabelInput!
    
    @IBOutlet weak var visitasTextField: FloatingLabelInput!
    
    @IBOutlet weak var mensajesTextField: FloatingLabelInput!
    
    @IBOutlet weak var sanidadesTextField: FloatingLabelInput!
    
    @IBOutlet weak var trabajoTextField: FloatingLabelInput!
    
    @IBOutlet weak var otrosTextView: UITextView!    
    
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
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace,doneButton], animated: false)
        
        avivamientosTextView.inputAccessoryView = toolBar
        bibliasTextView.inputAccessoryView = toolBar
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
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
        
        var reportData = Report(year: year, month: month, day: day, fecha: "",avivamientos: 0, hogares: 0, estudios_establecidos: 0, estudios_realizados: 0, estudios_asistidos: 0, biblias: 0, mensajeros: 0, porciones: 0, visitas: 0, ayunos: 0, horas_ayunos: 0, enfermos: 0, sanidades: 0, mensajes: 0, cultos: 0, devocionales: 0, horas_trabajo: 0, otros: "", email: email, password: password)
        
        reportData.avivamientos = Int(avivamientosTextView.text ?? "0") ?? 0
        reportData.biblias = Int(bibliasTextView.text ?? "0") ?? 0
        reportData.ayunos = Int(ayunosTextView.text ?? "0") ?? 0
        reportData.horas_ayunos = Int(horasAyunosTextView.text ?? "0") ?? 0
        reportData.cultos = Int(cultosTextView.text ?? "0") ?? 0
        reportData.devocionales = Int(devocionalesTextView.text ?? "0") ?? 0
        reportData.enfermos = Int(enfermosTextView.text ?? "0") ?? 0
        reportData.hogares = Int(hogaresTextView.text ?? "0") ?? 0
        reportData.estudios_asistidos = Int(asistidosTextField.text ?? "0") ?? 0
        reportData.estudios_establecidos = Int(establecidosTextField.text ?? "0") ?? 0
        reportData.estudios_realizados = Int(realizadosTextField.text ?? "0") ?? 0
        reportData.mensajeros = Int(mensajerosTextField.text ?? "0") ?? 0
        reportData.porciones = Int(porcionesTextField.text ?? "0") ?? 0
        reportData.visitas = Int(visitasTextField.text ?? "0") ?? 0
        reportData.mensajes = Int(mensajesTextField.text ?? "0") ?? 0
        reportData.sanidades = Int(sanidadesTextField.text ?? "0") ?? 0
        reportData.horas_trabajo = Int(trabajoTextField.text ?? "0") ?? 0
        reportData.otros = otrosTextView.text ?? ""
        
        
        self.loadingIndicator.startAnimating()
        
        // llamar al post request para agregar el reporte
        let postNewReportRequest = APINewReportRequest()
        
        postNewReportRequest.newReport(reportData, completion: { result in
            switch result{
            case .success(let newReportResponse):
                print("Se ha creado agregado el reporte satisfactoriamente: \(String(describing: newReportResponse.report))")
                                
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    // ir al historial de reportes
                    let mainTB = self.storyboard?.instantiateViewController(identifier: "mainTapBar") as! MainTabBarController
                    mainTB.modalPresentationStyle = .fullScreen
                    mainTB.selectedIndex = 1
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
