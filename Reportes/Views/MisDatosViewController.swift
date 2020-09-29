//
//  MisDatosViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 6/12/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class MisDatosViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var lugarLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var gradoLabel: UILabel!
    
    @IBOutlet weak var ministerioLabel: UILabel!
    
    @IBOutlet weak var responsabilidadLabel: UILabel!
    
    @IBOutlet weak var pastorLabel: UILabel!
    
    @IBOutlet weak var feligresiaNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.nombre)
        lugarLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.lugar)
        emailLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.email)
        
        gradoLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.grado)
        ministerioLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.ministerio)
        responsabilidadLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.responsabilidad)
        pastorLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.pastor)
        feligresiaNumberLabel.text = ManageUserData().getUserData(field: UserDefaults.Keys.id)
        
        
    }
    

    @IBAction func closeDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editDidTap(_ sender: Any) {
    }
    
}

class CloseSessionViewController: UIViewController {
    
    
    @IBAction func noDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func yesDidTap(_ sender: Any) {
        ManageUserData().DeleteUserData()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        // ir al first ViewController
        //let first = self.storyboard?.instantiateViewController(identifier: "firstVC") as! ViewController
        //first.modalPresentationStyle = .fullScreen
        //self.present(first, animated: true)
                
    }
}
