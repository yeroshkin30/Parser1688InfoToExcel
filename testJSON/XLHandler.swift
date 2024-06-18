import AppKit
import SwiftXLSX
import CoreXLSX


class XLCreator {
    func createExcelFile(with itemModels: [Model], images: [NSImage], imageByColor: [ItemPhotoByColor], id: String) {
        let items = itemModels.sorted(by: { (model1, model2) -> Bool in
            if model1.colorChina == model2.colorChina {
                return model1.sizeInfo.sizeLetter.rawValue < model2.sizeInfo.sizeLetter.rawValue
            }
            return model1.colorChina < model2.colorChina
        })
        let book = XWorkBook()
        // Create a new sheet
        let sheet = setupSheet(book: book)

        // Add header row
        var cell = createHeaderRow(for: sheet)
        cell = createSecondHeader(for: sheet)

        // Add rows for each person
        var row = 3
        var currentColor: String = items.first!.colorChina
        var needColor = true
        for item in items {
            cell = addCell(to: sheet, row: row, col: 1, width: 300)
            cell.value = .text("Name")

            if currentColor == item.colorChina {
                let image = imageByColor.first { $0.color == currentColor }!.image
                if needColor {
                    let imageCellValue: XImageCell = XImageCell(key: XImages.append(with: image)!, size: CGSize(width: 75, height: 75))
                    cell = addCell(to: sheet, row: row, col: 2)
                    cell.value = .icon(imageCellValue)
                    needColor = false
                }
            } else {
                currentColor = item.colorChina
                let image = imageByColor.first { $0.color == currentColor }!.image
                let imageCellValue: XImageCell = XImageCell(key: XImages.append(with: image)!, size: CGSize(width: 75, height: 75))
                cell = addCell(to: sheet, row: row, col: 2)
                cell.value = .icon(imageCellValue)
            }

            cell = addCell(to: sheet, row: row, col: 3)
            cell.value = .text(item.article)

            cell = addCell(to: sheet, row: row, col: 4)
            cell.value = .text(item.sku ?? "NOSKU")

            cell = addCell(to: sheet, row: row, col: 5)
            cell.value = .text(item.title ?? "No title")

            cell = addCell(to: sheet, row: row, col: 7)
            cell.value = .text(item.colorChina)

            cell = addCell(to: sheet, row: row, col: 8)
            cell.value = .text(item.colorEng)

            cell = addCell(to: sheet, row: row, col: 9)
            cell.value = .text(item.sizeInfo.sizeNameEng ?? item.sizeInfo.sizeNameChin)

            cell = addCell(to: sheet, row: row, col: 10)
            cell.value = .integer(item.quantity)

            cell = addCell(to: sheet, row: row, col: 11)
            cell.value = .text(item.price)
            
            cell = addCell(to: sheet, row: row, col: 12)
            cell.value = .text(item.productLength ?? "")

            cell = addCell(to: sheet, row: row, col: 13)
            cell.value = .text(item.shoulders ?? "")

            cell = addCell(to: sheet, row: row, col: 14)
            cell.value = .text(item.bustSize ?? "")

            cell = addCell(to: sheet, row: row, col: 15)
            cell.value = .text(item.waistSize ?? "")

            cell = addCell(to: sheet, row: row, col: 16)
            cell.value = .text(String(item.weight)) // !!!

            cell = addCell(to: sheet, row: row, col: 16)
            cell.value = .text(item.sleevelength ?? "")

            cell = addCell(to: sheet, row: row, col: 18)
            cell.value = .text("") // !!!

            cell = addCell(to: sheet, row: row, col: 20)
            cell.value = .text(String(item.fabric))

            row += 1
        }

        // Save the workbook to a file
        var fileid = book.save("\(id).xlsx")
        print("<<<File XLSX generated!>>>")
        print("\(fileid)")
        fileid.removeLast(4)

        saveImages(id: id, images: images, to: fileid)
        saveImagesByColor(id: id, photoByColors: imageByColor, to: fileid)
    }

    func setupSheet(book: XWorkBook) -> XSheet {
        let sheet = book.NewSheet("Persons")
        sheet.ForColumnSetWidth(1, 70)
        sheet.ForRowSetHeight(1, 50)
        sheet.ForColumnSetWidth(2, 60)
        sheet.ForRowSetHeight(2, 50)
        sheet.ForColumnSetWidth(4, 120)
        sheet.ForColumnSetWidth(5, 250)
        sheet.ForColumnSetWidth(6, 100)
        sheet.ForColumnSetWidth(7, 70)

        return sheet
    }

    func createSecondHeader(for sheet: XSheet) -> XCell {
        let headerRow = 2

        var cell = sheet.AddCell(XCoords(row: headerRow, col: 1))
        cell.value = .text("Enter the name from your brand label/填写品牌名字")
        cell = addCell(to: sheet, row: headerRow, col: 2)
        cell.value = .text("Add a photo/加图片")
        cell = addCell(to: sheet, row: headerRow, col: 3)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 4)
        cell.value = .text("SKU")
        cell = addCell(to: sheet, row: headerRow, col: 5)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 6)
        cell.value = .text("Product")
        cell = addCell(to: sheet, row: headerRow, col: 7)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 8)
        cell.value = .text("Color")
        cell = addCell(to: sheet, row: headerRow, col: 9)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 10)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 11)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 12)
        cell.value = .text("Product length (for each size)/衣长(对每个尺码)")
        cell = addCell(to: sheet, row: headerRow, col: 13)
        cell.value = .text("Shoulders length (for each size)/肩宽(对每个尺码)")
        cell = addCell(to: sheet, row: headerRow, col: 14)
        cell.value = .text("Bust (for each size)/胸围(对每个尺码)")
        cell = addCell(to: sheet, row: headerRow, col: 15)
        cell.value = .text("Waist (for each size)/腰围对每个尺码)")
        cell = addCell(to: sheet, row: headerRow, col: 16)
        cell.value = .text("Hips (for each size)/臀围(对每个尺码)")
        cell = addCell(to: sheet, row: headerRow, col: 17)
        cell.value = .text("Sleeve length (for each size)/袖长对每个尺码)")
        cell = addCell(to: sheet, row: headerRow, col: 18)
        cell.value = .text("Weight, kg")
        cell = addCell(to: sheet, row: headerRow, col: 19)
        cell.value = .text("产品体积/Product volume, cm")
        cell = addCell(to: sheet, row: headerRow, col: 20)
        cell.value = .text("Enter composition, in %")
        cell = addCell(to: sheet, row: headerRow, col: 21)
        cell.value = .text("Fabric")
        cell = addCell(to: sheet, row: headerRow, col: 23)

        return cell
    }

    func createHeaderRow(for sheet: XSheet) -> XCell {
        let headerRow = 1

        var cell = sheet.AddCell(XCoords(row: headerRow, col: 1))
        cell.value = .text("Brand/品牌")
        cell = addCell(to: sheet, row: headerRow, col: 2)
        cell.value = .text("Photo/图片")
        cell = addCell(to: sheet, row: headerRow, col: 3)
        cell.value = .text("Article №/货号")
        cell = addCell(to: sheet, row: headerRow, col: 4)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 5)
        cell.value = .text("Item name/名称")
        cell = addCell(to: sheet, row: headerRow, col: 6)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 7)
        cell.value = .text("Color/颜色")
        cell = addCell(to: sheet, row: headerRow, col: 8)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 9)
        cell.value = .text("Size/尺码")
        cell = addCell(to: sheet, row: headerRow, col: 10)
        cell.value = .text("Quantity/库存")
        cell = addCell(to: sheet, row: headerRow, col: 11)
        cell.value = .text("Wholesale price, CNY/ 批发价格")
        cell = addCell(to: sheet, row: headerRow, col: 12)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 13)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 14)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 15)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 16)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 17)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 18)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 19)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 20)
        cell.value = .text("Fabric/面料成分")
        cell = addCell(to: sheet, row: headerRow, col: 21)
        cell.value = .text("")
        cell = addCell(to: sheet, row: headerRow, col: 22)

        return cell
    }

    func addCell(to sheet: XSheet, row: Int, col: Int, width: Int? = nil) -> XCell {
        let cell = sheet.AddCell(XCoords(row: row, col: col))
        cell.alignmentHorizontal = .center
        if let width {
            cell.width = width
        }

        return cell
    }
}



func saveImagesByColor(id: String, photoByColors: [ItemPhotoByColor], to directoryPath: String) {
    let fileManager = FileManager.default

    // Ensure the directory exists, create if not
    if !fileManager.fileExists(atPath: directoryPath) {
        do {
            try fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating directory: \(error.localizedDescription)")
            return
        }
    }

    // Save each image
    for photoByColor in photoByColors {
        saveImage(to: directoryPath, image: photoByColor.image, id: id, name: photoByColor.color)
    }
}

func saveImages(id: String, images: [NSImage], to directoryPath: String) {
    let fileManager = FileManager.default

    // Ensure the directory exists, create if not
    if !fileManager.fileExists(atPath: directoryPath) {
        do {
            try fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating directory: \(error.localizedDescription)")
            return
        }
    }

    // Save each image
    for (index, image) in images.enumerated() {
        saveImage(to: directoryPath, image: image, id: id, name: String(index))
    }
}

func saveImage(to directoryPath: String, image: NSImage,id: String, name: String) {
    let imageData = image.tiffRepresentation
    guard let bitmapImage = NSBitmapImageRep(data: imageData!) else {
        print("Error converting NSImage to bitmap representation")
        return
    }

    guard let pngData = bitmapImage.representation(using: .png, properties: [:]) else {
        print("Error converting bitmap to PNG data")
        return
    }

    let filePath = (directoryPath as NSString).appendingPathComponent("\(id) \(name).png")
    do {
        try pngData.write(to: URL(fileURLWithPath: filePath))
        print("Saved image at: \(filePath)")
    } catch {
        print("Error saving image: \(error.localizedDescription)")
    }
}
