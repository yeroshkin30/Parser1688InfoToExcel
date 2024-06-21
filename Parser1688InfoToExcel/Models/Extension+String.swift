//
//  Extension+String.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 20.06.2024.
//

import Foundation

extension String {
     func separateSizeFromColor() -> (sizeChinese: String, colorChinese: String) {
        let props = self.split(separator: ";").map { String($0) }
        let propColor = props.count > 0 ? props[0] : ""
        let propSize = props.count > 1 ? props[1] : ""

        return (propColor, propSize)
    }
}
