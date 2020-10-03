//
//  InitViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 3/29/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 5, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 10, y: 0, width: 30, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
}

class InitViewController: UIViewController {
    @IBOutlet weak var alert: UILabel!{
        didSet{
            alert.isHidden = true
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField! {
       didSet {
          emailTextField.tintColor = UIColor.systemOrange
          emailTextField.setIcon(#imageLiteral(resourceName: "userIcon"))
       }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!{
       didSet {
          passwordTextField.tintColor = UIColor.systemOrange
          passwordTextField.setIcon(#imageLiteral(resourceName: "passwordIcon"))
       }
    }
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To hide the indicator at launch
        loadingIndicator.hidesWhenStopped = true

        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func iniciarTapped(_ sender: Any) {
        
        loadingIndicator.startAnimating()
        self.alert.isHidden = true
        
        let email = emailTextField.text ?? "empty"
        let password = passwordTextField.text ?? "empty"
        
        // Call the /getuser API with those credentials
        getUser(email: email, password: password) { (user) in
            print(user.nombre)
            print(user.id)
            
            // ir al otro viewcontroler
            DispatchQueue.main.async {
            let initNameVC = self.storyboard?.instantiateViewController(identifier: "initNameVC") as! InitNameViewController
            initNameVC.modalPresentationStyle = .fullScreen
            initNameVC.userData = user // Pasar estos datos al otro viewcontroler
            initNameVC.password = password
            self.present(initNameVC, animated: true)
            }
        }
    }
    
    // Aux methods
    
    let baseUrl = "https://www.sccristo.org"
    
    // Obterner los da†os desde el servidor
    func getUser(email:String, password:String ,completion: @escaping (User) -> ()) {
        print(email, password)
        guard let url = URL(string: baseUrl + "/getuser-ios/" + email + "/" + password) else { return }
        let session = URLSession.shared
        //var request = URLRequest(url: url)
        //request.httpMethod = "GET"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data , error == nil else {
                // OH NO! An client error occurred...
                print("No se pudo optener datos de la API")
                DispatchQueue.main.async { // Correct
                    self.alert.text = "Error en el cliente. Verifique la conexión a internet"
                    self.alert.isHidden = false
                    self.loadingIndicator.stopAnimating()
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // OH NO! An server error occurred...
                print("Error en el servidor")
                DispatchQueue.main.async { // Correct
                    self.alert.text = "Error en el servidor, inténtelo de nuevo"
                    self.alert.isHidden = false
                    self.loadingIndicator.stopAnimating()
                }
                return
            }
            guard let mime = response?.mimeType, mime == "application/json" else { // Cuando se deja alguna credenciales en blanco
                print("Wrong MIME type!")
                DispatchQueue.main.async {
                    self.alert.text = "Introduzca correo electrónico y contraseña"
                    self.alert.isHidden = false
                    self.loadingIndicator.stopAnimating()
                }
                return
            }
            
            // Have data
            do{
                let user = try JSONDecoder().decode( User.self, from: data)
                if(user.status == "fails"){
                    DispatchQueue.main.async {
                        self.alert.text = "Credenciales incorrectas"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                }else if(user.profile_complete || user.admin){
                    DispatchQueue.main.async {
                        self.alert.text = "El usuario especificado ya se ha creado una cuenta"
                        self.alert.isHidden = false
                        self.loadingIndicator.stopAnimating()
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.alert.isHidden = true
                        self.loadingIndicator.stopAnimating()
                        completion(user)
                    }
                }
            }catch{
                print("JSON error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.alert.text = "No se ha podido crear una cuenta con los datos proporcionados"
                    self.alert.isHidden = false
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
        
        task.resume()
    }
    

}
