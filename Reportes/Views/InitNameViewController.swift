//
//  InitNameViewController.swift
//  Reportes - Conjunto de view controls que forman parte del proceso sign up users
//
//  Created by Oisbel Simpson on 4/30/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: 1000, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemTeal.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
}


var userEditData: User?

class InitNameViewController: UIViewController {

    @IBOutlet weak var name : UITextField!
    
    @IBOutlet weak var place: UILabel!
    
    // Usado para
    var userData: User?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = userData, let pass = password{
            userEditData = data
            userEditData?.oldpassword = pass
            self.name.text = userEditData?.nombre
            self.place.text = userEditData?.lugar
        }
        
        // Only show botton border to textfield
        self.name.addBottomBorder()
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        guard let name = self.name.text, name != "" else {
            print("El campo nombre no puede estar en blanco")
            return
        }
        userEditData?.nombre = name
        // ir al otro viewcontroler
        let passwordVC = self.storyboard?.instantiateViewController(identifier: "passwordVC") as! PasswordViewController
        passwordVC.modalPresentationStyle = .fullScreen
        self.present(passwordVC, animated: true)
    }
    
}

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var alert: UILabel!{
        didSet{
            alert.isHidden = true
        }
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Only show botton border to textfield
        self.password.addBottomBorder()
        self.password.textContentType = .newPassword
        self.password.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; max-consecutive: 2; minlength: 6;")
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        }
    
    @IBAction func nextDidTap(_ sender: Any) {
        guard let pass = self.password.text, pass != "" else {
            print("Debe introducir una contraseña")
            alert.isHidden = false
            return
        }
        alert.isHidden = true
        userEditData?.password = pass
        // ir al otro viewcontroler
        let phoneVC = self.storyboard?.instantiateViewController(identifier: "phoneVC") as! PhoneViewController
        phoneVC.modalPresentationStyle = .fullScreen
        self.present(phoneVC, animated: true)
    }
}

class PhoneViewController: UIViewController {
    
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phone.addBottomBorder()
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        }
    
    @IBAction func nextDidTap(_ sender: Any) {
        guard let phone = self.phone.text else {
            return
        }
        userEditData?.phone = phone
        // ir al otro viewcontroler
        let birthdayVC = self.storyboard?.instantiateViewController(identifier: "birthdayVC") as! BirthdayViewController
        birthdayVC.modalPresentationStyle = .fullScreen
        self.present(birthdayVC, animated: true)
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class BirthdayViewController: UIViewController {
    
    @IBOutlet weak var birthday: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.birthday.addBottomBorder()
        createDatePicker()
        }
    
    func createDatePicker() -> Void {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        //assign toolbar
        birthday.inputAccessoryView = toolbar
        
        //assign date picker to the textfield
        birthday.inputView = datePicker
        
        // date picker mode
        datePicker.datePickerMode = .date
        
        // Para cambiar el idiona
        let loc = Locale(identifier: "es")
        datePicker.locale = loc
    }
    
    @objc func donePressed(){
        // Formater
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        
        //birthday.text = "\(datePicker.date)"
        birthday.text = formater.string(from: datePicker.date)
        
        formater.dateFormat = "yyyy"
        let year = Int(formater.string(from: datePicker.date)) ?? 0
        
        formater.dateFormat = "MM"
        let month = Int(formater.string(from: datePicker.date)) ?? 0
        
        formater.dateFormat = "dd"
        let day = Int(formater.string(from: datePicker.date)) ?? 0
        
        userEditData?.year = year
        userEditData?.month = month
        userEditData?.day = day
        
        self.view.endEditing(true)
    }

    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        
        guard let date = self.birthday.text, date != "" else {
            print("Debe seleccionar su fecha de nacimiento")
            return
        }
        
        // ir al otro viewcontroler
        let addressVC = self.storyboard?.instantiateViewController(identifier: "addressVC") as! AddressViewController
        addressVC.modalPresentationStyle = .fullScreen
        self.present(addressVC, animated: true)
    }
}

class AddressViewController: UIViewController {

    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var alert: UILabel!{
        didSet{
            alert.isHidden = true
        }
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        self.address.addBottomBorder()
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    @IBAction func nextDidTap(_ sender: Any) {
        
        guard let address = self.address.text, address != "" else {
            print("Dirección inválida")
            alert.isHidden = false
            return
        }
        alert.isHidden = true
        
        userEditData?.direccion = address
        // ir al otro viewcontroler
        let marriedVC = self.storyboard?.instantiateViewController(identifier: "marriedVC") as! MarriedViewController
        marriedVC.modalPresentationStyle = .fullScreen
        self.present(marriedVC, animated: true)
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class MarriedViewController: UIViewController {

    override func viewDidLoad() {
    super.viewDidLoad()
    }
    
    @IBAction func backDIdTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func NoDidTap(_ sender: Any) {
        // ir al otro viewcontroler
        let gradoVC = self.storyboard?.instantiateViewController(identifier: "gradoVC") as! GradoViewController
        gradoVC.modalPresentationStyle = .fullScreen
        self.present(gradoVC, animated: true)
    }
    
    @IBAction func YesDidTap(_ sender: Any) {
        // ir al otro viewcontroler
        let conyugeVC = self.storyboard?.instantiateViewController(identifier: "conyugeVC") as! ConyugeViewController
        conyugeVC.modalPresentationStyle = .fullScreen
        self.present(conyugeVC, animated: true)
    }
}

class ConyugeViewController: UIViewController {

    @IBOutlet weak var nameConyuge: UITextField!
    
    @IBOutlet weak var marriedDate: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    self.nameConyuge.addBottomBorder()
    self.marriedDate.addBottomBorder()
    createDatePicker()
    
    // Quitar teclado cuando de click outside keyboard
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tap)
    
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        
        guard let nombre_conyuge = self.nameConyuge.text, nombre_conyuge != "",
            let fecha_casamiento = self.marriedDate.text, fecha_casamiento != "" else {
            print("Datos del conyuge?")
            return
        }
        userEditData?.nombre_conyuge = nombre_conyuge
        userEditData?.fecha_casamiento = fecha_casamiento
        
        // ir al otro viewcontroler
        let gradoVC = self.storyboard?.instantiateViewController(identifier: "gradoVC") as! GradoViewController
        gradoVC.modalPresentationStyle = .fullScreen
        self.present(gradoVC, animated: true)
    }
    
    func createDatePicker() -> Void {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        //assign toolbar
        marriedDate.inputAccessoryView = toolbar
        
        //assign date picker to the textfield
        marriedDate.inputView = datePicker
        
        // date picker mode
        datePicker.datePickerMode = .date
        
        // Para cambiar el idiona
        let loc = Locale(identifier: "es")
        datePicker.locale = loc
    }
    
    @objc func donePressed(){
        // Formater
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        
        //birthday.text = "\(datePicker.date)"
        marriedDate.text = formater.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
}

class GradoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
   
    @IBOutlet weak var gradoValue: UITextField!
    
    @IBOutlet weak var grado: UIPickerView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
        forComponent component: Int) -> String? {

            // Return a string from the array for this row.
            return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        gradoValue.text = pickerData[row]
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange])
    }
       
    let pickerData = ["Buen Samaritano", "Centinela", "Brigada de Luz", "Predicador Auxiliar", "Predicador", "Pre-Evangelista", "Evangelista(o Diaconisa)", "Maestro/a Evangelista", "Supervisor", "Superintendente", "Obispo", "Arzobispo", "Apostol"]
    
    override func viewDidLoad() {
    super.viewDidLoad()
        // Connect data:
        //grado = UIPickerView()
        self.grado.delegate = self
        self.grado.dataSource = self
    
        //gradoValue.inputView = grado
        gradoValue.text = pickerData[0]
    }
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        guard let gradoValue = gradoValue.text else {
            return
        }
        userEditData?.grado = gradoValue
        
        // ir al otro viewcontroler
        let ministerioVC = self.storyboard?.instantiateViewController(identifier: "ministerioVC") as! MinisterioViewController
        ministerioVC.modalPresentationStyle = .fullScreen
        self.present(ministerioVC, animated: true)
    }
    
    
}

class MinisterioViewController: UIViewController {

    @IBOutlet weak var ministerio: UITextField!
    override func viewDidLoad() {
    super.viewDidLoad()
        self.ministerio.addBottomBorder()
        
        // Quitar teclado cuando de click outside keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextDidTap(_ sender: Any) {
        guard let ministerioValue = ministerio.text else {
            return
        }
        userEditData?.ministerio = ministerioValue
        
        // ir al otro viewcontroler
        let responsabilidadVC = self.storyboard?.instantiateViewController(identifier: "responsabilidadVC") as! ResponsabilidadViewController
        
        // Enviar datos al proximo viewcontroller
        responsabilidadVC.userEditData = userEditData
        
        responsabilidadVC.modalPresentationStyle = .fullScreen
        self.present(responsabilidadVC, animated: true)
    }
    
}
