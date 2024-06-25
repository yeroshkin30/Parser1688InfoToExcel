//
//  DataController.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 21.06.2024.
//

import Foundation

var currentLink: String = ""

@Observable
class DataController {

    var itemTypes: ItemTypes = .none
    var loadingState: LoadingState = .loaded("Enter link")
    // MARK: - Private properties

    private let networkController: NetworkController = .init()
    private let xlCreator: XLCreator = .init()
    private let modelHandler: ModelConverter = .init()

    var convertedModel: DataModelConverted?
    var bagData: BagEditData = .init()
    var sizesData: [SizeData] = []

    func getDataFromURL(string: String) {
        currentLink = string
        itemTypes = .none
        Task {
            do {
                let model: MainModel = try await networkController.getMainModel(from: string)
                loadingState = .loading("Converting model")
                let convertedModel: DataModelConverted = try await modelHandler.convert(from: model.data)
                loadingState = .loaded("Converted model created")
                bagData = .init(
                    fabricChinese: convertedModel.productProperties.fabricForBags,
                    strapsData: convertedModel.productProperties.straps
                )
                sizesData = getUniqueSizeData(from: convertedModel.itemsByColor).sorted { $0.sizeInfo.sizeLetter.rawValue < $1.sizeInfo.sizeLetter.rawValue }
                itemTypes = .cloth
                self.convertedModel = convertedModel
            } catch {
                print(error)
            }
        }
    }


    func createTestJson() {
        currentLink = "testing"
        itemTypes = .none
        setupModels()
    }
//    func createXLFile() {
//        guard let convertedModel else { return }
//        let bagModel: BagModel = createBagModel(from: convertedModel, bagData: bagData)
//
//        loadingState = .loading("Creating XL file")
//        Task {
////            xlCreator.createExcelFile(from: bagModel, images: bagModel.images, id: String(convertedModel.id))
//            loadingState = .loaded("XL file was created")
//        }
//    }

    func createXLFile() {
        guard let convertedModel else { return }
        let clothModel: ClothModel = createClothModel(from: convertedModel, sizeData: sizesData)

        loadingState = .loading("Creating XL file")
        Task {
            xlCreator.createExcelFile(from: clothModel, images: clothModel.images, id: String(convertedModel.id))
            loadingState = .loaded("XL file was created")
        }
    }

    func setupModels() {

        guard let path = Bundle.main.path(forResource: "third", ofType: "json") else { return }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let mainModel = try decoder.decode(MainModel.self, from: data)
            Task {
                let convertedModel = try await modelHandler.convert(from: mainModel.data)
                loadingState = .loaded("Converted model created")
                sizesData = getUniqueSizeData(from: convertedModel.itemsByColor)
                itemTypes = .cloth
                self.convertedModel = convertedModel
            }
        } catch {
            print("Error in \(#function) - \(error.localizedDescription)")
            return
        }
    }

    func getUniqueSizeData(from items: [ItemByColor]) -> [SizeData] {
        var sets: Set<SizeData> = .init()

        for item in items {
            for sizeAndQuantity in item.dataBySize {
                sets.insert(sizeAndQuantity.sizeData)
            }
        }

        return Array(sets)
    }

    func createBagModel(from data: DataModelConverted, bagData: BagEditData) -> BagModel {
        BagModel(
            title: data.title,
            images: data.mainImagesData,
            article: data.productProperties.article ?? String(data.id),
            aritcleAndColorSku: nil,
            productName: "need name",
            price: data.price,
            itemsByColor: data.itemsByColor,
            weight: data.weight,
            compositionChinese: data.productProperties.fabricForBags ?? "",
            bagSize: bagData.bagSize,
            fabric: bagData.fabric,
            strap: bagData.straps
        )
    }

    func createClothModel(from data: DataModelConverted, sizeData: [SizeData]) -> ClothModel {
        var itemsByColor = data.itemsByColor
        updateSizeData(in: &itemsByColor, with: sizeData)

        return ClothModel(
            title: data.title,
            images: data.mainImagesData,
            article: data.productProperties.article ?? String(data.id),
            aritcleAndColorSku: nil,
            productName: "need name",
            price: data.price,
            itemsByColor: itemsByColor,
            weight: data.weight,
            compositionChinese: data.productProperties.fabricForBags ?? "",
            fabric: data.productProperties.fabricValueChinise ?? ""
        )
    }

    func updateSizeData(in items: inout [ItemByColor], with newSizeData: [SizeData]) {
        for (itemIndex, item) in items.enumerated() {
            for (sizeIndex, sizeAndQuantity) in item.dataBySize.enumerated() {
                let letter = sizeAndQuantity.sizeData.sizeInfo.sizeLetter
                if let newSizeData = newSizeData.first(where: { $0.sizeInfo.sizeLetter == letter }) {
                    items[itemIndex].dataBySize[sizeIndex].sizeData = newSizeData
                }
            }
        }
    }
}

enum LoadingState {
    case loading(String)
    case loaded(String)
}

enum ItemTypes {
    case bags
    case cloth
    case none
}
