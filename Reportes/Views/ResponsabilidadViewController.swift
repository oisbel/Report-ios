//
//  ResponsabilidadViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 5/30/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class ResponsabilidadViewController: UIViewController {

    @IBOutlet weak var responsabilidad: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var userEditData: User?
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        responsabilidad.addBottomBorder()
        
        loadingIndicator.hidesWhenStopped = true
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneDIdTap(_ sender: Any) {
        
        guard let responsabilidadValue = responsabilidad.text else {
            return
        }
        self.userEditData?.responsabilidad = responsabilidadValue
        
        //let mirror = Mirror(reflecting: userEditData!)
        //for child in mirror.children  {
        //    print("key: \(String(describing: child.label)), value: \(child.value)") }
        
        guard let userData = self.userEditData, let user_id = self.userEditData?.id else {
            print("User data not available")
            return
        }
        
        // llamar al post request para inicializar al usuario
        
        let postEditUserRequest = APIEditUserRequest(userId: user_id)
        
        postEditUserRequest.editUser(userData, completion: { result in
            switch result{
            case .success(let editUserResponse):
                print("Se ha creado la cuenta satisfactoriamente: \(String(describing: editUserResponse.user))")
                // Guardar los datos del usuario creado localmente
                ManageUserData().SaveUserData(userData: self.userEditData!, password: self.userEditData?.password ?? "pass")
                
                DispatchQueue.main.async {
                    // ir al mainTabBar
                    let mainTB = self.storyboard?.instantiateViewController(identifier: "mainTapBar") as! MainTabBarController
                    mainTB.modalPresentationStyle = .fullScreen
                    self.present(mainTB, animated: true)
                }
            case .failure(let error):
                print("Ocurrió un error \(error)")
            }
        })
    }
}
