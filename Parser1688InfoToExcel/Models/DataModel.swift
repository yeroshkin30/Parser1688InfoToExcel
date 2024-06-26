//
//  DataModel.swift
//  testJSON
//
//  Created by oleh yeroshkin on 13.06.2024.
//

import AppKit

struct DataModel: Codable {
    let item_id: Int
    let title: String
    let product_props: [[String: String]]
    let main_imgs: [URL]
    let sku_props: [SKUProps]
    let skus: [[String: String]]
    let delivery_info: DeliveryInfo
    let price_info: PriceInfo

    enum CondingKeys: String, CodingKey {
        case item_id  // Number on site
        case title
        case product_props
        case main_imgs
        case delivery_info
        case price_info
    }
}

struct SKUProps: Codable {
    let propName: String
    let pid: String
    let values: [SKUValue]

    enum CodingKeys: String, CodingKey {
        case propName = "prop_name"
        case pid
        case values
    }
}

struct DeliveryInfo: Codable {
    let unit_weight: Float
}

//{
//  "name": "漂白色",
//  "vid": "0",
//  "imageUrl": "https://cbu01.alicdn.com/img/ibank/O1CN01qAed9u1ks3IHYIJIn_!!2210260454738-0-cib.jpg"
//}
struct SKUValue: Codable {
    let name: String
    let vid: String
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case name
        case vid
        case imageUrl = "imageUrl"
    }
}


struct PhotoByColor {
    let colorChinese: String
    let imageData: Data
}

// Intermediate model with color and single size
struct ItemWithColorSize {
    let quantity: String
    let color: ColorInfo
    let sizeData: SizeData
}
