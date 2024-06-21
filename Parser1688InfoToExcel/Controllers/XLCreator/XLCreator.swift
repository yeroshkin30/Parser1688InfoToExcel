import AppKit
import SwiftXLSX

class XLCreator {
    func createExcelFile(from model: BagModel, images: [Data], id: String) {
        let book = XWorkBook()
        // Create a new sheet
        let sheet = setupSheet(book: book)
        // Add header row
        var cell = createHeaderRow(for: sheet)
        cell = createSecondHeader(for: sheet)

        var row = 3

        for item in model.itemsByColor {

            if let imageData = item.imageData, let image = NSImage(data: imageData) {
                let imageSize: CGSize = .init(width: 130, height: 130)
                let imageCellValue: XImageCell = XImageCell(key: XImages.append(with: image)!, size: imageSize)
                cell = addCell(to: sheet, row: row, col: .image, width: 200)
                cell.value = .icon(imageCellValue)
            }

            for sizeAndQuantity in item.dataBySize {
                cell = addCell(to: sheet, row: row, col: .brand, width: 300)
                cell.value = .text("Chaopindai")

                cell = addCell(to: sheet, row: row, col: .article)
                cell.value = .text(model.article)

                cell = addCell(to: sheet, row: row, col: .itemName)
                cell.value = .text(model.title ?? "No title")

                cell = addCell(to: sheet, row: row, col: .colorChinese)
                cell.value = .text(item.color.chinese)

                cell = addCell(to: sheet, row: row, col: .colorEng)
                cell.value = .text(item.color.english?.colorNameEng ?? "")

                cell = addCell(to: sheet, row: row, col: .size)
                cell.value = .text(model.bagSize)
                /// For clothes
                //            cell.value = .text(model.sizeInfo.sizeNameEng ?? model.sizeInfo.sizeNameChin)

                cell = addCell(to: sheet, row: row, col: .quantity)
                cell.value = .text(sizeAndQuantity.quantity)

                cell = addCell(to: sheet, row: row, col: .price)
                cell.value = .text(model.price)

                //            cell = addCell(to: sheet, row: row, col: 12)
                //            cell.value = .text(item.productLength ?? "")
                //
                //            cell = addCell(to: sheet, row: row, col: 13)
                //            cell.value = .text(item.shoulders ?? "")
                //
                //            cell = addCell(to: sheet, row: row, col: 14)
                //            cell.value = .text(item.bustSize ?? "")
                //
                //            cell = addCell(to: sheet, row: row, col: 15)
                //            cell.value = .text(item.waistSize ?? "")

                cell = addCell(to: sheet, row: row, col: .weight)
                cell.value = .float(model.weight) // !!!

                //            cell = addCell(to: sheet, row: row, col: 16)
                //            cell.value = .text(item.sleevelength ?? "")
                //
                //            cell = addCell(to: sheet, row: row, col: 18)
                //            cell.value = .text(String(item.weight)) // !!!
                //
                //            cell = addCell(to: sheet, row: row, col: 20)
                //            cell.value = .text(String(item.fabric))
                cell = addCell(to: sheet, row: row, col: .bagSize)
                cell.value = .text(model.bagSize)

                cell = addCell(to: sheet, row: row, col: .compositionChinese)
                cell.value = .text(model.compositionChinese)

                cell = addCell(to: sheet, row: row, col: .fabric)
                cell.value = .text(model.fabric)

                cell = addCell(to: sheet, row: row, col: .straps)
                cell.value = .text(model.strap)

                cell = addCell(to: sheet, row: row, col: .link)
                cell.value = .text(currentLink)

                sheet.ForRowSetHeight(row, 134)

                row += 1
            }
        }

        sheet.buildindex()
        sheet.MergeRect(XRect(1, 11, 7, 1))

//        currentColor = items.first!.colorChina
//        row = 3
//        var startRow = 3
//        var finishRow = 3
//
//        for (index, item) in items.enumerated() {
//            if currentColor != item.colorChina  {
//                finishRow = row
//                sheet.MergeRect(XRect(startRow, 2, 1, finishRow - startRow))
//                currentColor = item.colorChina
//                startRow = row
//            } else if index == items.count - 1 {
//                finishRow = row + 1
//                sheet.MergeRect(XRect(startRow, 2, 1, finishRow - startRow))
//            }
//            row += 1
//        }

        // Save the workbook to a file
        var fileid = book.save("\(id).xlsx")
        print("<<<File XLSX generated!>>>")
        print("\(fileid)")
        fileid.removeLast(5)

        saveImages(id: model.article, images: images, to: fileid)
        saveImagesByColor(id: model.article, itemsByColors: model.itemsByColor, to: fileid)
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
        cell.Border = true

        return cell
    }

    func addCell(to sheet: XSheet, row: Int, col  name: ColumnName, width: Int? = nil) -> XCell {
        let cell = sheet.AddCell(XCoords(row: row, col: name.rawValue))
        cell.alignmentHorizontal = .center
        if let width {
            cell.width = width
        }
        cell.Border = true
        cell.alignmentHorizontal = .center

        return cell
    }
}



func saveImagesByColor(id: String, itemsByColors: [ItemByColor], to directoryPath: String) {
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
    for photoByColor in itemsByColors {
        saveImage(
            to: directoryPath,
            imageData: photoByColor.imageData,
            id: id,
            name: photoByColor.color.english?.colorNameEng ?? photoByColor.color.chinese
        )
    }
}

func saveImages(id: String, images: [Data], to directoryPath: String) {
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
    for (index, imageData) in images.enumerated() {
        saveImage(to: directoryPath, imageData: imageData, id: id, name: String(index))
    }
}

func saveImage(to directoryPath: String, imageData: Data?, id: String, name: String) {
    guard let imageData, let bitmapImage = NSBitmapImageRep(data: imageData) else {
        print("Error converting NSImage to bitmap representation")
        return
    }

    guard let pngData = bitmapImage.representation(using: .png, properties: [:]) else {
        print("Error converting bitmap to PNG data")
        return
    }

    let filePath = (directoryPath as NSString).appendingPathComponent("\(id)_\(name).png")
    do {
        try pngData.write(to: URL(fileURLWithPath: filePath))
        print("Saved image at: \(filePath)")
    } catch {
        print("Error saving image: \(error.localizedDescription)")
    }
}
