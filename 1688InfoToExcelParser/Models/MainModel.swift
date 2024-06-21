//
//  MainModel.swift
//  testJSON
//
//  Created by oleh yeroshkin on 13.06.2024.
//

import Foundation


struct MainModel: Codable {
    let code: Int?
    let massage: String
    let data: DataModel

    enum CodingKeys: String, CodingKey {
        case code
        case massage = "msg"
        case data
    }
}

struct PriceInfo: Codable {
    let price: String
}
