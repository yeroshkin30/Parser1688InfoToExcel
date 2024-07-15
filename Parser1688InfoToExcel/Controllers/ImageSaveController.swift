//
//  ImageSaveController.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 15.07.2024.
//

import AppKit

class ImageSaveController {

    func saveImage(image: NSImage, name: String, article: String) {

        guard let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first else {
             print("Error accessing Downloads directory")
             return
         }

        let articleDirectory = downloadsDirectory.appendingPathComponent(article)
           do {
               try FileManager.default.createDirectory(at: articleDirectory, withIntermediateDirectories: true, attributes: nil)
               print("Folder created or already exists at: \(articleDirectory.path)")
           } catch {
               print("Error creating folder: \(error.localizedDescription)")
               return
        }

        let filePath = articleDirectory.appendingPathComponent("\(name).png")

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
