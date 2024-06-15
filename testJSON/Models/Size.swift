//
//  Size.swift
//  testJSON
//
//  Created by oleh yeroshkin on 13.06.2024.
//

import Foundation


enum Size: Int {
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
