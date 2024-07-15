//
//  BagEditData.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 13.07.2024.
//

import Foundation

struct BagEditData: Identifiable {
    let id: UUID = .init()
    var fabricChinese: String? = nil
    var strapsData: String? = nil
    var bagSize: String = ""
    var fabric: String = ""
    var straps: String = ""
}
