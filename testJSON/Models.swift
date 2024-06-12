import AppKit

struct DataModel: Codable {
    let item_id: Int
    let title: String
    let product_props: [[String: String]]
    let main_imgs: [URL]
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

        return .init(
            id: data.item_id,
            title: data.title,
            productProperties: productProps,
            price: data.price_info.price,
            images: images,
            itemTypes: itemsBySize,
            weight: data.delivery_info.unit_weight
        )
    }

    private func transformSku(from sku: [[String: String]]) -> [ItemType] {

        var itemsBySizeAndColor: [ItemType] = []
        for dictionari in sku {
            let itemsAmount = dictionari[Keys.itemAmount.rawValue] ?? "No amount"

            let propNames = dictionari[Keys.propNames.rawValue] ?? "No prop names"
            let (color, size) = separateSizeFromColor(from: propNames)
            let sizeEnum = Size.getEnum(from: size)

            itemsBySizeAndColor.append(ItemType(
                quantity: Int(itemsAmount) ?? 66666666,
                color: color,
                size: size,
                sizeEnum: sizeEnum
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
}

// MARK: - Main model

struct DataModelConverted {
    let id: Int
    let title: String
    let productProperties: ProductProperties
    let price: String
    let images: [NSImage]
    let itemTypes: [ItemType]
    let weight: Float
}

// MARK: - Product properties

struct SkusTransformet {

}

struct ItemType {
    let quantity: Int
    let color: String
    let size: String
    let sizeEnum: Size
}

struct DeliveryInfo: Codable {
    let unit_weight: Float
}

struct Model {
    let title: String?
    let images: [NSImage]
    let article: String
    let sku: String?
    let productName: String? // dress

    let color: String
    let size: String
    let sizeEnum: Size
    let price: String

    let quantity: Int
    let productLength: Int?
    let bustSize: Int?
    let waistSize: Int?
    let sleevelength: Int?
    let weight: Float
    let fabric: String
}
