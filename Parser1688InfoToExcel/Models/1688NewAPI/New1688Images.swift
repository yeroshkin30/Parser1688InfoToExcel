//
//  New1688.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 15.07.2024.
//

import Foundation

struct New1688Images: Codable {
    let result: ImagesURL
    var allURLStrings: [String] {
        print("descimg: \(result.item.desc_imgs.count)")
        print("main images: \(result.item.images.count)")
        return result.item.desc_imgs + result.item.images
    }
}

struct ImagesURL: Codable {
    let item: DeskImages
}

struct DeskImages: Codable {
    let desc_imgs: [String]
    let images: [String]
}
