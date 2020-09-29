//
//  LogInViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 3/30/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var alert: UILabel!{
        didSet{
            alert.isHidden = true
        }
    }
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // To hide the indicator at launch
        loadingIndicator.hidesWhenStopped = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingIndicator.stopAnimating()
        self.alert.isHidden = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
        
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        loadingIndicator.startAnimating()
        self.alert.isHidden = true
        
        guard let email = emailTextField.text, let password = passwordTextField.text  else {
            print("Proporcione los datos de usuario")
            self.alert.text = "Introduzca correo electrónico y contraseña"
            self.alert.isHidden = false
            self.loadingIndicator.stopAnimating()
            return
        }
        
        // llamar al get request para iniciar sesion al usuario
        
        let gettUserRequest = APIGetUserRequest(email: email, password: password)
        
        gettUserRequest.getUser(completion: { result in
            switch result{
            case .success(let user):
                print("Se ha iniciado sesion satisfactoriamente: \(String(describing: user.nombre))")
                
                // Guardar los datos del usuario creado localmente
                ManageUserData().SaveUserData(userData: user, password: password)
                
                DispatchQueue.main.async {
                    // ir al mainTabBar
                    let mainTB = self.storyboard?.instantiateViewController(identifier: "mainTapBar") as! MainTabBarController
                    mainTB.modalPresentationStyle = .fullScreen
                    self.present(mainTB, animated: true)
                }
            case .failure(let error):
                switch error {
                case .clientProblem:
                    DispatchQueue.main.async {
                        self.alert.text = "Error en el cliente. Verifique la conexión a internet"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                case .emptyFields:
                    DispatchQueue.main.async {
                        self.alert.text = "Introduzca correo electrónico y contraseña"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                case .serverProblem:
                    DispatchQueue.main.async {
                        self.alert.text = "Error en el servidor, inténtelo de nuevo"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                case .wrongCredentials, .decodingProblem:
                    DispatchQueue.main.async {
                        self.alert.text = "Credenciales incorrectas"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                case .messageProblem:
                    DispatchQueue.main.async {
                        self.alert.text = "El usuario especificado no puede iniciar session"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                case .activeProblem:
                    DispatchQueue.main.async {
                        self.alert.text = "El usuario especificado ha sido desactivado por el administrador"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                case .profileCompleteProblem:
                DispatchQueue.main.async {
                    self.alert.text = "Primero debe crear una cuenta"
                    self.alert.isHidden = false
                    self.loadingIndicator.stopAnimating()
                }
                default:
                    DispatchQueue.main.async {
                        self.alert.text = "Ocurrió un error\(error)"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                }
            }
        })
        
    }
}
