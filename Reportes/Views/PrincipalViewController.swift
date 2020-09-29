//
//  PrincipalViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 5/20/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit
import SafariServices

class PrincipalViewController: UIViewController {

    
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = ManageUserData().getUserData(field: UserDefaults.Keys.nombre)        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func misDatosDidTap(_ sender: Any) {
        
        // ir a MisDatosViewCOntroller
        guard let misDatosVC = self.storyboard?.instantiateViewController(identifier: "misDatosVC") as? MisDatosViewController else{
            return
        }
        misDatosVC.modalPresentationStyle = .fullScreen
        self.present(misDatosVC, animated: true)
        
    }
    
    @IBAction func crearReporteDidTap(_ sender: Any) {
        // ir a CreateReporteViewCOntroller
        guard let createReportVC = self.storyboard?.instantiateViewController(identifier: "createReportVC") as? CreateReportViewController else{
            return
        }
        createReportVC.modalPresentationStyle = .fullScreen
        self.present(createReportVC, animated: true)
    }
    
    @IBAction func crearEstudio(_ sender: Any) {
        // ir a CreateBiblicalViewCOntroller
        guard let createBiblicalVC = self.storyboard?.instantiateViewController(identifier: "createBiblicalVC") as? CreateBiblicalViewController else{
            return
        }
        createBiblicalVC.modalPresentationStyle = .fullScreen
        self.present(createBiblicalVC, animated: true)
    }
    
    
    @IBAction func helpDidTap(_ sender: Any) {
    }
    
    @IBAction func sccDidTap(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.soldadosdelacruz.org")!)
        present(vc, animated: true)
    }
    
    @IBAction func didTapRadio(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "http://radiodirectoalcorazon.com")!)
        present(vc, animated: true)
    }
    
    @IBAction func didTapFacebook(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.facebook.com/radiodirectoalcorazon")!)
        present(vc, animated: true)
    }
    
}
