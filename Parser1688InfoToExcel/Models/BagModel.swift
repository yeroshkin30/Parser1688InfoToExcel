//
//  BagModel.swift
//  1688InfoToExcelParser
//
//  Created by Oleh Yeroshkin on 21.06.2024.
//

import Foundation

struct BagModel {
    let title: String?
    let images: [Data]
    let article: String
    let articleAndColorSku: String?
    let productName: String? // dress
    let price: String

    let itemsByColor: [ItemByColor]

    let weight: Float
    let compositionChinese: String
    let bagSize: String
    let fabric: String
    let strap: String
}

struct ClothModel {
    let title: String?
    let images: [Data]
    let article: String
    let articleAndColorSku: String?
    let productName: String? // dress
    let price: String

    let itemsByColor: [ItemByColor]

    let weight: Float
    let compositionChinese: String
    let fabric: String
}




