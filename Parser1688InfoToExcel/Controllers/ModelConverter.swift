//
//  ModelConverter.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 21.06.2024.
//

import Foundation

class ModelConverter {
    func convert(from data: DataModel) async throws -> DataModelConverted {
        let imagesData = try await getImagesData(from: data.main_imgs)
        let productProps: ProductProperties = .init(prop: data.product_props)
        let itemPhotosByColor: [PhotoByColor] = await getPhotosByColor(from: data.sku_props)
        let itemsByColor: [ItemByColor] = transformPropertiesByItem(from: data.skus, photosByColor: itemPhotosByColor)

        print("DataModelConverted created")

        return .init(
            id: data.item_id,
            title: data.title,
            productProperties: productProps,
            price: data.price_info.price,
            mainImagesData: imagesData,
            itemsByColor: itemsByColor,
            weight: data.delivery_info.unit_weight
        )
    }
}

private extension ModelConverter {

    //    {
    //      "skuid": "4828077161253",
    //      "specid": "48ccca68ae9968d79544dc7b03294cdb",
    //      "sale_price": "39.90",
    //      "origin_price": "39.90",
    //      "stock": "94123",
    //      "sale_count": "1383",
    //      "props_names": "海洋蓝;175/100A(L)",
    //      "props_ids": "0:5;1:2"
    //    },
    func transformPropertiesByItem(from propertiesByItem: [[String: String]], photosByColor: [PhotoByColor]) -> [ItemByColor] {

        var itemModels: [ItemWithColorSize] = []
        for property in propertiesByItem {
            let quantity = property[Keys.itemAmount.rawValue] ?? "No amount"
            let colorAndSizeString = property[Keys.propNames.rawValue] ?? "No prop names"

            let (colorChinese, sizeChinese) = colorAndSizeString.separateSizeFromColor()
            let colorInfo: ColorInfo = .init(chinese: colorChinese)
            let sizeInfo: SizeInfo = .init(sizeChinese: sizeChinese)

            itemModels.append(.init(
                quantity: quantity,
                color: colorInfo,
                sizeData: .init(sizeInfo: sizeInfo)
            ))
        }

        let itemsByColor = convertToItemsByColor(from: itemModels, photosByColor: photosByColor)

        return itemsByColor
    }

    func convertToItemsByColor(from models: [ItemWithColorSize], photosByColor: [PhotoByColor]) -> [ItemByColor] {
        var colorGroupedData: [ColorInfo: [SizeAndQuantity]] = [:]

        for item in models {
            let sizeAndQuantity = SizeAndQuantity(sizeData: item.sizeData, quantity: item.quantity)

            if var dataBySize = colorGroupedData[item.color] {
                dataBySize.append(sizeAndQuantity)
                colorGroupedData[item.color] = dataBySize
            } else {
                colorGroupedData[item.color] = [sizeAndQuantity]
            }
        }

        // Convert to array of ItemModel
        let itemsByColor: [ItemByColor] = colorGroupedData.map { (color, dataBySize) in
            let imageData = photosByColor.first { $0.colorChinese == color.chinese }?.imageData
            return ItemByColor(color: color, imageData: imageData, dataBySize: dataBySize)
        }

        return itemsByColor
    }

    func getPhotosByColor(from skuprops: [SKUProps]) async -> [PhotoByColor] {
        guard let colorSkus = skuprops.first(where: { $0.propName == "颜色" }) else {
            print("⚠️ No photos by color")
            return []
        }

        var itemsPhotoByColor: [PhotoByColor] = []

        for itemWithColor in colorSkus.values {
            if let itemPhotoByColor = await getPhotoByColor(from: itemWithColor) {
                itemsPhotoByColor.append(itemPhotoByColor)
            }
        }

        print("ItemPhotosByColor created. Total: \(itemsPhotoByColor.count)")

        return itemsPhotoByColor
    }


    func getPhotoByColor(from itemWithColor: SKUValue) async -> PhotoByColor? {
        if let imageURL = itemWithColor.imageUrl,
           let imageData = try? await getImageData(from: URL(string: imageURL)!) {

            return PhotoByColor(colorChinese: itemWithColor.name, imageData: imageData)
        } else {
            print("Cant get and image from URL photo by color")
            return nil
        }
    }


    func getColorNameEng(from colorNameChinese: String) -> ColorNameEng? {
        for color in ColorNameEng.allCases {
            if colorNameChinese.contains(color.rawValue) {
                return color
            }
        }

        return nil
    }

    enum Keys: String {
        case propNames = "props_names"
        case itemAmount = "stock"
    }
}
