//
//  DeleteBiblicalRequest.swift
//  Reportes
//
//  Created by Oisbel Simpson on 10/2/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

final class DeleteBiblicalResponse: Decodable{
    var biblical:Int? // el biblical.id devuelto por el servidor
    var message:String? // el mensaje de error devuelto por el servidor
}

struct APIDeleteBiblicalRequest {
    let resourceURL: URL
    let baseUrl = "https://www.sccristo.org"
    
    init(biblicalId: Int){
        let resourceString =  baseUrl + "/" + "deletebiblical-ios" + "/" + String(biblicalId)
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func deleteBiblical(_ credencials:EmailPassword, completion: @escaping(Result<DeleteBiblicalResponse, APIError>) -> Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(credencials)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                    jsonData = data else {
                        completion(.failure(.responseProblem))
                        return
                }
                // Have data
                do {
                    let deleteBiblicalResponseData = try JSONDecoder().decode(DeleteBiblicalResponse.self, from: jsonData)
                    guard let biblical = deleteBiblicalResponseData.biblical else{
                        completion(.failure(.messageProblem))
                        print(String(deleteBiblicalResponseData.message!) )
                        return
                    }
                    print("Id biblical removed is:\(biblical)")
                    completion(.success(deleteBiblicalResponseData))
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
}
