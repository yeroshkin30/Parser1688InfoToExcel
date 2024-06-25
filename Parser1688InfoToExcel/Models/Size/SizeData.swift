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


extension SizeData: Hashable {
    static func == (lhs: SizeData, rhs: SizeData) -> Bool {
        lhs.sizeInfo == rhs.sizeInfo
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sizeInfo)
    }
}

struct SizeProperties {
    var length: String = ""
    var shoulder: String = ""
    var bust: String = ""
    var waist: String = ""
    var hips: String = ""
    var sleeve: String = ""
}
