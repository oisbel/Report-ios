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
    
    @IBOutlet weak var avivamientos: UILabel!
    @IBOutlet weak var biblias: UILabel!
    @IBOutlet weak var cultos: UILabel!
    @IBOutlet weak var enfermos: UILabel!
    @IBOutlet weak var establecidos: UILabel!
    @IBOutlet weak var hogares: UILabel!
    @IBOutlet weak var mensajes: UILabel!
    @IBOutlet weak var sanidades: UILabel!
    @IBOutlet weak var horas: UILabel!
    @IBOutlet weak var ayunos: UILabel!
    @IBOutlet weak var horasAyunos: UILabel!
    @IBOutlet weak var devocionales: UILabel!
    @IBOutlet weak var asistidos: UILabel!
    @IBOutlet weak var realizados: UILabel!
    @IBOutlet weak var mensajeros: UILabel!
    @IBOutlet weak var porciones: UILabel!
    @IBOutlet weak var visitas: UILabel!    
    @IBOutlet weak var otros: UILabel!
    
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
            
            FillReport(actualReport: actualReport)
            
        }else{
            print("El reporte esta vacío o esta")
        }
        
    }
    
    
    func FillReport(actualReport: Report){
        avivamientos.text = "\(actualReport.avivamientos)"
        biblias.text = "\(actualReport.biblias)"
        cultos.text = "\(actualReport.cultos)"
        enfermos.text = "\(actualReport.enfermos)"
        establecidos.text = "\(actualReport.estudios_establecidos)"
        hogares.text = "\(actualReport.hogares)"
        mensajes.text = "\(actualReport.mensajes)"
        sanidades.text = "\(actualReport.sanidades)"
        horas.text = "\(actualReport.horas_trabajo)"
        ayunos.text = "\(actualReport.ayunos)"
        horasAyunos.text = "\(actualReport.horas_ayunos)"
        asistidos.text = "\(actualReport.estudios_asistidos)"
        realizados.text = "\(actualReport.estudios_realizados)"
        mensajeros.text = "\(actualReport.mensajeros)"
        porciones.text = "\(actualReport.porciones)"
        visitas.text = "\(actualReport.visitas)"
        otros.text = actualReport.otros
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
