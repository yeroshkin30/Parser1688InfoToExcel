//
//  BagModel.swift
//  1688InfoToExcelParser
//
//  Created by Oleh Yeroshkin on 21.06.2024.
//

import Foundation

protocol CommonModel { 
    var brand: String { get set }
    var title: String? { get }
    var images: [Data] { get }
    var article: String { get }
    var articleAndColorSku: String? { get }
    var productName: String? { get }
    var price: String { get }
    var itemsByColor: [ItemByColor] { get }
}

struct BagModel: CommonModel {
    var brand: String = ""
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

struct ClothModel: CommonModel {
    var brand: String = ""
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




