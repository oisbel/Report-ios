//
//  UserData.swift
//  Reportes
//
//  Created by Oisbel Simpson on 4/13/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    let status: String
    let church_id: Int
    var lugar: String
    var pastor: String
    let id: Int
    var nombre: String
    let email: String
    var phone: String
    var year: Int
    var month: Int
    var day : Int
    var direccion: String
    var nombre_conyuge: String
    var fecha_casamiento: String
    var grado: String
    var ministerio: String
    var responsabilidad: String
    var active: Bool
    var admin: Bool
    var super_admin: Bool
    var profile_complete: Bool
    var oldpassword: String?
    var password: String?
}

extension UserDefaults{
    enum Keys: String, CaseIterable{
        case church_id
        case lugar
        case pastor
        case id
        case nombre
        case email
        case phone
        case year
        case month
        case day
        case direccion
        case nombre_conyuge
        case fecha_casamiento
        case grado
        case ministerio
        case responsabilidad
        case password
    }
    // Elimina todos los datos de usuario alamacenado localmente
    func reset(){
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}

class ManageUserData{
    
    let defaults = UserDefaults.standard
    
    func SaveUserData(userData:User, password:String) -> () {
        defaults.set(userData.church_id, forKey: UserDefaults.Keys.church_id.rawValue)
        defaults.set(userData.lugar, forKey: UserDefaults.Keys.lugar.rawValue)
        defaults.set(userData.pastor, forKey: UserDefaults.Keys.pastor.rawValue)
        defaults.set(userData.id, forKey: UserDefaults.Keys.id.rawValue)
        defaults.set(userData.nombre, forKey: UserDefaults.Keys.nombre.rawValue)
        defaults.set(userData.email, forKey: UserDefaults.Keys.email.rawValue)
        defaults.set(userData.phone, forKey: UserDefaults.Keys.phone.rawValue)
        defaults.set(userData.year, forKey: UserDefaults.Keys.year.rawValue)
        defaults.set(userData.month, forKey: UserDefaults.Keys.month.rawValue)
        defaults.set(userData.day, forKey: UserDefaults.Keys.day.rawValue)
        defaults.set(userData.direccion, forKey: UserDefaults.Keys.direccion.rawValue)
        defaults.set(userData.nombre_conyuge, forKey: UserDefaults.Keys.nombre_conyuge.rawValue)
        defaults.set(userData.fecha_casamiento, forKey: UserDefaults.Keys.fecha_casamiento.rawValue)
        defaults.set(userData.grado, forKey: UserDefaults.Keys.grado.rawValue)
        defaults.set(userData.ministerio, forKey: UserDefaults.Keys.ministerio.rawValue)
        defaults.set(userData.responsabilidad, forKey: UserDefaults.Keys.responsabilidad.rawValue)
        defaults.set(password, forKey: UserDefaults.Keys.password.rawValue)
        
    }
    
    func DeleteUserData(){
        defaults.reset()
    }
    
    // Determina si hay un usuario logeado en el dispositivo
    func IsUserDataStoraged() -> Bool {
        let id = defaults.integer(forKey: UserDefaults.Keys.id.rawValue)
        if(id == 0) {
            return false
        }
        return true
    }
    
    // Devuelve el campo string especificado
    func getUserData(field: UserDefaults.Keys ) -> String {
        let name = defaults.string(forKey: field.rawValue) ?? ""
        return name
    }
    
    // Lee el id
    func getIdUserData() -> Int {
        let id = defaults.integer(forKey: UserDefaults.Keys.id.rawValue)
        return id
    }
}
