//
//  EditUserRequest.swift
//  Reportes
//
//  Created by Oisbel Simpson on 5/30/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

final class EditUserResponse: Decodable{
    var user:Int?
    var message:String?
}

struct APIEditUserRequest {
    let resourceURL: URL
    let baseUrl = "https://www.sccristo.org"
    
    init(userId: Int){
        let resourceString =  baseUrl + "/" + "edituser-ios" + "/" + String(userId)
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func editUser(_ userToEdit:User, completion: @escaping(Result<EditUserResponse, APIError>) -> Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToEdit)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                    jsonData = data else {
                        completion(.failure(.responseProblem))
                        return
                }
                // Have data
                do {
                    let editUserResponseData = try JSONDecoder().decode(EditUserResponse.self, from: jsonData)
                    guard let user = editUserResponseData.user else{
                        completion(.failure(.messageProblem))
                        print(String(editUserResponseData.message!) )
                        return
                    }
                    print("Id is:\(user)")
                    completion(.success(editUserResponseData))
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
