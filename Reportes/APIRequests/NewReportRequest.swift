//
//  NewReportRequest.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/12/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

final class NewReportResponse: Decodable{
    var report:Int? // el report.id devuelto por el servidor
    var message:String? // el mensaje de error devuelto por el servidor
}

struct APINewReportRequest {
    let resourceURL: URL
    let baseUrl = "https://www.sccristo.org"
    
    init(){
        let resourceString =  baseUrl + "/" + "addreport-ios"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func newReport(_ newReport:Report, completion: @escaping(Result<NewReportResponse, APIError>) -> Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(newReport)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                    jsonData = data else {
                        completion(.failure(.responseProblem))
                        return
                }
                // Have data
                do {
                    let addReportResponseData = try JSONDecoder().decode(NewReportResponse.self, from: jsonData)
                    guard let report = addReportResponseData.report else{
                        completion(.failure(.messageProblem))
                        print(String(addReportResponseData.message!) )
                        return
                    }
                    print("Id report is:\(report)")
                    completion(.success(addReportResponseData))
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
