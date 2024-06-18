import AppKit

// MARK: - Product properties

struct ItemType {
    let quantity: Int
    let color: String
    let colorEng: String
    let sizeInfo: SizeInfo

    static func getUniqueSizeInfos(from itemTypes: [ItemType]) -> [SizeInfo] {
        var uniqueSizeLetters = Set<SizeLetter>()
        var uniqueSizeInfos = [SizeInfo]()

        for item in itemTypes {
            let sizeLetter = item.sizeInfo.sizeLetter
            if !uniqueSizeLetters.contains(sizeLetter) {
                uniqueSizeLetters.insert(sizeLetter)
                uniqueSizeInfos.append(item.sizeInfo)
            }
        }

        return uniqueSizeInfos
    }
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
