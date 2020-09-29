//
//  GetBiblicalsRequest.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/24/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

struct GetBiblicalsResponse: Decodable{
    var biblicals: [Biblical]?
    var message: String? // el mensaje de error devuelto por el servidor
}

struct APIGetBiblicalsRequest {
    let baseUrl = "https://www.sccristo.org"
    let resourceURL: URL
    
    init(email:String, password:String){
        let resourceString = baseUrl + "/biblicals-ios/" + email + "/" + password
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getBiblicals(completion: @escaping(Result<GetBiblicalsResponse, APIError>) -> Void) {
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
                    print("Correo electrónico o contraseña en blanco")
                    completion(.failure(.emptyFields))
                    return
                }
                // Have data
                do {
                    let getBiblicalsResponseData = try JSONDecoder().decode(GetBiblicalsResponse.self, from: jsonData)
                    
                    guard let biblicals = getBiblicalsResponseData.biblicals else{
                        completion(.failure(.messageProblem))
                        print(String(getBiblicalsResponseData.message!) )
                        return
                    }
                    print("Cantidad de estudios recuperados:\(String(describing: biblicals.count))")
                    completion(.success(getBiblicalsResponseData))
                    
                }catch{
                    print("JSON error: \(error.localizedDescription)")
                    completion(.failure(.decodingProblem))
                }
            }
            
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
}
