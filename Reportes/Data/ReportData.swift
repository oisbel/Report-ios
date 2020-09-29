//
//  ReportData.swift
//  Reportes
//
//  Created by Oisbel Simpson on 9/12/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import Foundation


struct Report: Codable {
    var year: Int
    var month: Int
    var day: Int
    var fecha: String
    var avivamientos: Int
    var hogares: Int
    var estudios_establecidos: Int
    var estudios_realizados: Int
    var estudios_asistidos: Int
    var biblias: Int
    var mensajeros : Int
    var porciones: Int
    var visitas: Int
    var ayunos: Int
    var horas_ayunos: Int
    var enfermos: Int
    var sanidades: Int
    var mensajes: Int
    var cultos: Int
    var devocionales: Int
    var horas_trabajo: Int
    var otros: String?
    var email : String?
    var password: String?
}
