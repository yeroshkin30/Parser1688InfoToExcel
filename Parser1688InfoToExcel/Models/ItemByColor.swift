//
//  ItemByColor.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 20.06.2024.
//

import Foundation

/// Item with single color and array of sizes.
struct ItemByColor {
    let color: ColorInfo
    let imageData: Data?
    var dataBySize: [SizeAndQuantity]

    init(color: ColorInfo, imageData: Data?, dataBySize: [SizeAndQuantity]) {
        self.color = color
        self.imageData = imageData
        self.dataBySize = dataBySize.sorted {
            $0.sizeData.sizeInfo.sizeLetter.rawValue < $1.sizeData.sizeInfo.sizeLetter.rawValue
        }
    }
}

struct SizeAndQuantity {
    var sizeData: SizeData
    let quantity: String
}

struct ColorInfo: Hashable {
    let chinese: String
    var english: ColorNameEng?

    init(chinese: String) {
        self.chinese = chinese
        self.english = getColorNameEng(from: chinese)
    }

    private func getColorNameEng(from colorNameChinese: String) -> ColorNameEng? {
         for color in ColorNameEng.allCases {
             if colorNameChinese.contains(color.rawValue) {
                 return color
             }
         }

         return nil
    }
}
