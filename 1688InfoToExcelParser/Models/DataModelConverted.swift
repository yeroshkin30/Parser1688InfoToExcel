//
//  DataModelConverted.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 20.06.2024.
//

import Foundation

struct DataModelConverted {
    let id: Int
    let title: String
    let productProperties: ProductProperties
    let price: String
    let mainImagesData: [Data]
    let itemsByColor: [ItemByColor]
    let weight: Float
}
