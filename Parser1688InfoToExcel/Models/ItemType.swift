import AppKit

// MARK: - Product properties

struct ItemType {
    let quantity: Int
    let color: String
    let colorEng: String?
    let sizeInfo: SizeInfo
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
