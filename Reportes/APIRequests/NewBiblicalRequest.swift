//
//  NewBblicalRequest.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/21/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

final class NewBiblicalResponse: Decodable{
    var biblical:Int? // el biblical.id devuelto por el servidor
    var message:String? // el mensaje de error devuelto por el servidor
}

struct APINewBiblicalRequest {
    let resourceURL: URL
    let baseUrl = "https://www.sccristo.org"
    
    init(){
        let resourceString =  baseUrl + "/" + "addbiblical-ios"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func newBiblical(_ newBiblical:Biblical, completion: @escaping(Result<NewBiblicalResponse, APIError>) -> Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(newBiblical)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                    jsonData = data else {
                        completion(.failure(.responseProblem))
                        return
                }
                // Have data
                do {
                    let addBiblicalResponseData = try JSONDecoder().decode(NewBiblicalResponse.self, from: jsonData)
                    guard let biblical = addBiblicalResponseData.biblical else{
                        completion(.failure(.messageProblem))
                        print(String(addBiblicalResponseData.message!) )
                        return
                    }
                    print("Id biblical is:\(biblical)")
                    completion(.success(addBiblicalResponseData))
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
