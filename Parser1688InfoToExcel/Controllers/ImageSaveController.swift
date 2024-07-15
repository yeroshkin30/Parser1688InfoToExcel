//
//  ImageSaveController.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 15.07.2024.
//

import AppKit

class ImageSaveController {

    func saveImage(image: NSImage, name: String) {

        guard let directoryPath = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first else {
             print("Error accessing Downloads directory")
             return
         }
        let filePath = directoryPath.appendingPathComponent("\(name).png")

        guard let tiffData = image.tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffData) else {
            print("Error converting NSImage to bitmap representation")
            return
        }

        guard let pngData = bitmapImage.representation(using: .png, properties: [:]) else {
            print("Error converting bitmap to PNG data")
            return
        }

        do {
            try pngData.write(to: filePath)
            print("Saved image at: \(filePath)")
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }

}
