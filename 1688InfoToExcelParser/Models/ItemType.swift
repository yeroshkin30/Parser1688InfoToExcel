import AppKit

// MARK: - Product properties

struct ItemType {
    let quantity: Int
    let color: String
    let colorEng: String?
    let sizeInfo: SizeInfo
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

    let colorChina: String
    let colorEng: String
    let sizeInfo: SizeInfo
    let price: String

    let quantity: Int
    let productLength: String?
    let shoulders: String?
    let bustSize: String?
    let waistSize: String?
    let hips: String?
    let sleevelength: String?
    let weight: Float
    let fabric: String
}

struct BagModel {
    let title: String?
    let images: [Data]
    let article: String
    let aritcleAndColorSku: String?
    let productName: String? // dress
    let price: String

    let itemsByColor: [ItemByColor]

    let weight: Float
    let compositionChinese: String
    let bagSize: String
    let fabric: String
    let strap: String
}


