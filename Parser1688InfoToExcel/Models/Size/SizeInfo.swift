//
//  SizeInfo.swift
//  testJSON
//
//  Created by oleh yeroshkin on 18.06.2024.
//

import Foundation

struct SizeInfo: Equatable, Hashable {
    let sizeNameChin: String
    let sizeLetter: SizeLetter
    var sizeNameEng: String?

    init(sizeChinese: String) {
        self.sizeNameChin = sizeChinese
        self.sizeLetter = SizeInfo.findSize(in: sizeChinese)
        self.sizeNameEng = SizeLetter.getEnum(from: sizeChinese)?.value

    }

    static func findSize(in chineseString: String) -> SizeLetter {
        // Iterate over reversed allCases to check from longest to shortest
        for size in SizeLetter.allCases.reversed() {
            if chineseString.contains(size.value) {
                return size
            }
        }
        return .oneSize
    }

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

enum SizeLetter: Int, CaseIterable {
    case S = 1
    case M = 2
    case L = 3
    case XL = 4
    case XXL = 5
    case XL2 = 6
    case XXXL = 7
    case XL3 = 8
    case XXXXL = 9
    case XL4 = 10
    case oneSize = 11

    static func getEnum(from size: String) -> Self? {
        switch size {
        case "S":
            return .S
        case "M":
            return .M
        case "L":
            return .L
        case "XL":
            return .XL
        case "XXL":
            return .XXL
        case "2XL":
            return .XL2
        case "XXXL":
            return .XXXL
        case "3XL":
            return .XL3
        case "XXXXL":
            return .XXXXL
        case "4XL":
            return .XL4
        case "oneSize":
            return nil
        default:
            return nil
        }
    }

    var value: String {
        switch self {
        case .S:
            return "S"
        case .M:
            return "M"
        case .L:
            return "L"
        case .XL:
            return "XL"
        case .XXL:
            return "XXL"
        case .XXXL:
            return "XXXL"
        case .oneSize:
            return "oneSize"
        case .XL2:
            return "2XL"
        case .XL3:
            return "3XL"
        case .XXXXL:
            return "XXXXL"
        case .XL4:
            return "4XL"
        }
    }
}
