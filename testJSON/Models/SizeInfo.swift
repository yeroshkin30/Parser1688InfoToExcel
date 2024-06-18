//
//  SizeInfo.swift
//  testJSON
//
//  Created by oleh yeroshkin on 18.06.2024.
//

import Foundation

struct SizeInfo {
    let sizeNameChin: String
    let sizeLetter: SizeLetter
    var sizeNameEng: String?

    init(sizeChinese: String) {
        self.sizeNameChin = sizeChinese
        self.sizeLetter = SizeInfo.findSize(in: sizeChinese)
        self.sizeNameEng = SizeLetter.getEnum(from: sizeChinese).value

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
}

enum SizeLetter: Int, CaseIterable {
    case S = 1
    case M = 2
    case L = 3
    case XL = 4
    case XXL = 5
    case XXXL = 6
    case oneSize = 7

    static func getEnum(from size: String) -> Self {
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
        case "XXXL":
            return .XXXL
        case "oneSize":
            return .oneSize
        default:
            return .oneSize
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
        }
    }
}
