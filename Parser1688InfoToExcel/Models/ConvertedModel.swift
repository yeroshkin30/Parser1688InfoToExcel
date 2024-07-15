//
//  DataModelConverted.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 20.06.2024.
//

import Foundation

struct ConvertedModel {
    let id: Int
    let title: String
    let productProperties: ProductProperties
    let price: String
    let mainImagesData: [Data]
    let mainImagesURL: [URL]
    let itemsByColor: [ItemByColor]
    let weight: Float
}
