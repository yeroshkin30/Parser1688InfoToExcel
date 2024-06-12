import AppKit
import SwiftXLSX
import CoreXLSX


class XLCreator {
    func createExcelFile(with itemModels: [Model], id: String) {
        let items = itemModels.sorted(by: { (model1, model2) -> Bool in
            if model1.color == model2.color {
                return model1.sizeEnum.rawValue < model2.sizeEnum.rawValue
            }
            return model1.color < model2.color
        })
        // Create a new workbook
        let book = XWorkBook()

        // Create a new sheet
        let sheet = book.NewSheet("Persons")

        // Add header row
        var cell = createHeaderRow(for: sheet)
        cell = createSecondHeader(for: sheet)
        // Add rows for each person
        var row = 3
        for item in items {
            cell = sheet.AddCell(XCoords(row: row, col: 1))
            cell.value = .text("noone")

            cell = sheet.AddCell(XCoords(row: row, col: 2))
            cell.value = .text("Photo")

            cell = sheet.AddCell(XCoords(row: row, col: 3))
            cell.value = .text(item.article)

            cell = sheet.AddCell(XCoords(row: row, col: 4))
            cell.value = .text(item.sku ?? "NOSKU")

            cell = sheet.AddCell(XCoords(row: row, col: 5))
            cell.value = .text(item.title ?? "No title")

            cell = sheet.AddCell(XCoords(row: row, col: 8))
            cell.value = .text(item.color)

            cell = sheet.AddCell(XCoords(row: row, col: 9))
            cell.value = .text(item.size)

            cell = sheet.AddCell(XCoords(row: row, col: 10))
            cell.value = .integer(item.quantity)

            cell = sheet.AddCell(XCoords(row: row, col: 11))
            cell.value = .text(item.price)

            cell = sheet.AddCell(XCoords(row: row, col: 18))
            cell.value = .text(String(item.weight))

            cell = sheet.AddCell(XCoords(row: row, col: 19))
            cell.value = .text(String(item.fabric))



            row += 1
        }

        // Save the workbook to a file
        let fileid = book.save("\(id).xlsx")
        print("<<<File XLSX generated!>>>")
        print("\(fileid)")
//        let test = XWorkBook.test()

    }


    func createSecondHeader(for sheet: XSheet) -> XCell {
        let headerRow = 2

        var cell = sheet.AddCell(XCoords(row: headerRow, col: 1))
        cell.value = .text("Enter the name from your brand label/填写品牌名字")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 2))
        cell.value = .text("Add a photo/加图片")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 3))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 4))
        cell.value = .text("SKU")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 5))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 6))
        cell.value = .text("Product")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 7))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 8))
        cell.value = .text("Color")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 9))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 10))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 11))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 12))
        cell.value = .text("Product length (for each size)/衣长(对每个尺码)")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 13))
        cell.value = .text("Shoulders length (for each size)/肩宽(对每个尺码)")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 14))
        cell.value = .text("Bust (for each size)/胸围(对每个尺码)")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 15))
        cell.value = .text("Waist (for each size)/腰围对每个尺码)")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 16))
        cell.value = .text("Hips (for each size)/臀围(对每个尺码)")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 17))
        cell.value = .text("Sleeve length (for each size)/袖长对每个尺码)")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 18))
        cell.value = .text("Weight, kg")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 19))
        cell.value = .text("产品体积/Product volume, cm")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 20))
        cell.value = .text("Enter composition, in %")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 21))
        cell.value = .text("Fabric")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 23))
        return cell
    }

    func createHeaderRow(for sheet: XSheet) -> XCell {
        let headerRow = 1

        var cell = sheet.AddCell(XCoords(row: headerRow, col: 1))
        cell.value = .text("Brand/品牌")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 2))
        cell.value = .text("Photo/图片")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 3))
        cell.value = .text("Article №/货号")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 4))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 5))
        cell.value = .text("Item name/名称")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 6))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 7))
        cell.value = .text("Color/颜色")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 8))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 9))
        cell.value = .text("Size/尺码")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 10))
        cell.value = .text("Quantity/库存")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 11))
        cell.value = .text("Wholesale price, CNY/ 批发价格")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 12))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 13))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 14))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 15))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 16))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 17))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 18))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 19))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 20))
        cell.value = .text("Fabric/面料成分")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 21))
        cell.value = .text("")
        cell = sheet.AddCell(XCoords(row: headerRow, col: 22))

        return cell
    }
}
