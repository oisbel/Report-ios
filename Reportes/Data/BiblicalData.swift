//
//  BiblicalData.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/21/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation

struct Biblical: Codable {
    var year: Int
    var month: Int
    var day: Int
    var nombre: String
    var direccion: String
    var email : String?
    var password: String?
    var id: Int?
}
