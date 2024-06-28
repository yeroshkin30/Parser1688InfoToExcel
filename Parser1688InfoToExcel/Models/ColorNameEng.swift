//
//  Colors.swift
//  testJSON
//
//  Created by oleh yeroshkin on 13.06.2024.
//

import Foundation


enum ColorNameEng: String, CaseIterable {
    case black = "黑色"
    case black2 = "黑颜色"

    case yellow = "黄色"

    case green = "绿色"
    case green2 = "绿颜色"

    case purple = "紫色"
    case purple2 = "紫颜色"

    case pink = "粉红色"
    case pink2 = "粉红"

    case red = "红色"
    case blue = "蓝色"
    case golden = "金色"
    case orange = "橘色"
    case creamyWhite = "米白"
    case apricot = "杏色"
    case noName = "No name"

    case white = "白色"
    case milkyWhite = "奶白"
    case coffeeWhite = "奶咖色"

    case grey = "灰色"
    case lightPurple = "淡紫"
    case mingGreen = "薄荷绿"
    case champane = "香槟"
    case brown = "咖啡"
    case brown2 = "棕色"
    case beige = "肤色"

    case wineBrown = "酒咖色"
    case wineBrown2 = "酒咖啡色"

    case sunsetYellow = "日落黄色"
    case sunsetYellow2 = "日落黄"

    case smokyBlue = "烟蓝色"
    case caramel = "焦糖色"
    case hazeBlue = "雾霾蓝"
    case darkBrown = "深棕色"
    case almondGreen = "杏仁绿色"
    case elephantGrey = "大象灰色"

    case khaki = "卡其"
    case khaki2 = "卡其色"

    case bananaGreen = "香蕉绿色"
    case burgundy = "酒红色"
    case royalBlue = "宝蓝色"
    case darkGreen = "墨绿色"
    case lightGreen = "浅绿色"

    var colorNameEng: String {
        switch self {
        case .black, .black2:
            return "Black"
        case .yellow:
            return "Yellow"
        case .green, .green2:
            return "Green"
        case .purple, .purple2:
            return "Purple"
        case .pink, .pink2:
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
        case .white:
            return "White"
        case .grey:
            return "Grey"
        case .milkyWhite:
            return "Milky white"
        case .coffeeWhite:
            return "Milk coffee"
        case .lightPurple:
            return "Light purple"
        case .mingGreen:
            return "Mint green"
        case .champane:
            return "Champane"
        case .brown, .brown2:
            return "Brown"
        case .beige:
            return "Beige"
        case .noName:
            return "No name"
        case .wineBrown, .wineBrown2:
            return "Wine Brown"
        case .sunsetYellow, .sunsetYellow2:
            return "Sunset Yellow"
        case .smokyBlue:
            return "Smoky Blue"
        case .caramel:
            return "Caramel"
        case .hazeBlue:
            return "Haze Blue"
        case .darkBrown:
            return "Dark Brown"
        case .almondGreen:
            return "Almond Green"
        case .elephantGrey:
            return "Elephant Grey"
        case .khaki, .khaki2:
            return "Khaki"
        case .bananaGreen:
            return "Banana Green"
        case .burgundy:
            return "Burgundy"
        case .royalBlue:
            return "Royal Blue"
        case .darkGreen:
            return "Dark Green"
        case .lightGreen:
            return "Light Green"
        }
    }
}
