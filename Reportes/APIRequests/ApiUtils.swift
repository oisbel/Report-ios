//
//  ApiUtils.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/12/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation


enum APIError: Error{
    case responseProblem
    case decodingProblem
    case encodingProblem
    case messageProblem
    case serverProblem
    case clientProblem
    case emptyFields
    case wrongCredentials
    case activeProblem
    case profileCompleteProblem
}

let Months = [1:"Enero", 2:"Febrero", 3:"Marzo", 4:"Abril", 5:"Mayo",
              6:"Junio", 7:"Julio", 8:"Agosto", 9:"Septiembre", 10:"Octubre", 11:"Noviembre", 12:"Diciembre"]

let MonthsShort = [1:"Ene", 2:"Feb", 3:"Mar", 4:"Abr", 5:"May",
6:"Jun", 7:"Jul", 8:"Ago", 9:"Sep", 10:"Oct", 11:"Nov", 12:"Dic"]
