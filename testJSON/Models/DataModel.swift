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

    func convert(from data: DataModel) async throws -> DataModelConverted {
        let images = try await getImages(from: data.main_imgs)
        let productProps: ProductProperties = .init(prop: data.product_props)
        let itemsBySize: [ItemType] = transformSku(from: data.skus)
        let itemPhotosByColor = await getItemPhotosByColor(from: data.sku_props)

        print("Main model converted")
        return .init(
            id: data.item_id,
            title: data.title,
            productProperties: productProps,
            price: data.price_info.price,
            images: images,
            itemTypes: itemsBySize,
            imtePhotoByColor: itemPhotosByColor,
            weight: data.delivery_info.unit_weight
        )
    }

    private func getItemPhotosByColor(from skuprops: [SKUProps]) async -> [ItemPhotoByColor] {
        guard let colorSkus = skuprops.first(where: { $0.propName == "颜色" }) else {
            print("⚠️ No photos by color")
            return []
        }

        var colorPhotos: [ItemPhotoByColor] = []
        for itemWithColor in colorSkus.values {
            if let imageURL = itemWithColor.imageUrl,
               let image = try? await getImage(from: URL(string: imageURL)!) {

                colorPhotos.append(
                    ItemPhotoByColor(
                        color: itemWithColor.name,
                        image: image
                    )
                )
            } else {
                print("Cant get and image from URL photo byt color")
            }
        }

        print("ItemPhotosByColor created. Total: \(colorPhotos.count)")

        return colorPhotos
    }

    private func transformSku(from sku: [[String: String]]) -> [ItemType] {

        var itemsBySizeAndColor: [ItemType] = []
        for dictionari in sku {
            let itemsAmount = dictionari[Keys.itemAmount.rawValue] ?? "No amount"

            let propNames = dictionari[Keys.propNames.rawValue] ?? "No prop names"
            let (color, sizeChinese) = separateSizeFromColor(from: propNames)
            let colorEng = getColorNameEng(from: color)

            itemsBySizeAndColor.append(ItemType(
                quantity: Int(itemsAmount) ?? 1121231231231231,
                color: color,
                colorEng: colorEng.colorNameEng,
                sizeInfo: .init(sizeChinese: sizeChinese)
            ))
        }

        return itemsBySizeAndColor
    }

    enum Keys: String {
        case propNames = "props_names"
        case itemAmount = "stock"
    }

    private func separateSizeFromColor(from propNames: String) -> (size: String, color: String) {
        let props = propNames.split(separator: ";").map { String($0) }
        let propColor = props.count > 0 ? props[0] : ""
        let propSize = props.count > 1 ? props[1] : ""

        return (propColor, propSize)
    }

   private func getColorNameEng(from colorNameChinese: String) -> ColorNameEng {
        for color in ColorNameEng.allCases {
            if colorNameChinese.contains(color.rawValue) {
                return color
            }
        }

        return ColorNameEng.noName
    }
}

// Define the structures for the JSON model
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

// MARK: - Main model

struct DataModelConverted {
    let id: Int
    let title: String
    let productProperties: ProductProperties
    let price: String
    let images: [NSImage]
    let itemTypes: [ItemType]
    let imtePhotoByColor: [ItemPhotoByColor]
    let weight: Float
}

struct ItemPhotoByColor {
    let color: String
    let image: NSImage
}
