//
//  GetUserRequest.swift
//  Reportes
//
//  Created by Oisbel Simpson on 6/3/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

struct APIGetUserRequest {
    let baseUrl = "https://www.sccristo.org"
    let resourceURL: URL
    
    init(email:String, password:String){
        let resourceString = baseUrl + "/getuser-ios/" + email + "/" + password
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getUser(completion: @escaping(Result<User, APIError>) -> Void) {
        do{
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: resourceURL) { data, response, error in
                guard let jsonData = data , error == nil else {
                    // OH NO! An client error occurred...
                    print("Error en el cliente. Verifique la conexión a internet")
                    completion(.failure(.clientProblem))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        print("Error en el servidor, inténtelo de nuevo")
                        completion(.failure(.serverProblem))
                        return
                }
                guard let mime = response?.mimeType, mime == "application/json" else { // Cuando se deja alguna credenciales en blanco
                    print("Introduzca correo electrónico y contraseña")
                    completion(.failure(.emptyFields))
                    return
                }
                // Have data
                do {
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    
                    if(user.status == "fails"){
                        print("Credenciales incorrectas")
                        completion(.failure(.wrongCredentials))
                    }else if(user.admin){
                        print("El usuario especificado no puede iniciar session")
                        completion(.failure(.messageProblem))
                    }else if(!user.active){
                        print("El usuario especificado ha sido desactivado por el administrador")
                        completion(.failure(.activeProblem))
                    }else if(!user.profile_complete){
                        print("Primero debe crear una cuenta")
                        completion(.failure(.profileCompleteProblem))
                    }
                    else{
                        print("Id is:\(user.id)")
                        completion(.success(user))
                    }
                }catch{
                    print("JSON error: \(error.localizedDescription)")
                    print("Credenciales incorrectas")
                    completion(.failure(.decodingProblem))
                }
            }
            
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
}
