//
//  Colors.swift
//  testJSON
//
//  Created by oleh yeroshkin on 13.06.2024.
//

import Foundation


enum ColorNameEng: String, CaseIterable {
    case  black = "黑色"
    case  yellow = "黄色"
    case  green = "绿色"
    case  purple = "紫色"
    case  pink = "粉红色"
    case  red = "红色"
    case  blue = "蓝色"
    case  golden = "金色"
    case  orange = "橘色"
    case  creamyWhite = "米白"
    case  apricot = "杏色"
    case  noName = "No name"

    var colorNameEng: String {
        switch self {
        case .black:
            return "Black"
        case .yellow:
            return "Yellow"
        case .green:
            return "Green"
        case .purple:
            return "Purple"
        case .pink:
            return "Pink"
        case .red:
            return "Red"
        case .blue:
            return "Blue"
        case .golden:
            return "Golden"
        case .orange:
            return "Orange"
        case .creamyWhite:
            return "CreamyWhite"
        case .apricot:
            return "Apricot"
        case .noName:
            return "No name"
        }
    }
}
