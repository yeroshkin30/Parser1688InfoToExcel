//
//  SizeData.swift
//  testJSON
//
//  Created by oleh yeroshkin on 18.06.2024.
//

import Foundation

struct SizeData: Identifiable {
    let id: UUID = .init()
    let sizeInfo: SizeInfo
    var sizeProperties: SizeProperties = .init()
}

struct SizeProperties {
    var productLength: String = ""
    var shoulderLength: String = ""
    var bust: String = ""
    var waist: String = ""
    var hips: String = ""
    var sleeve: String = ""
}
