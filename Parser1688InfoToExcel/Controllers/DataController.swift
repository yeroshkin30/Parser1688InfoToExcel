//
//  DataController.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 21.06.2024.
//

import SwiftUI

var currentLink: String = ""

@Observable
class DataController {

    var itemType: ProductType = .bags
    var showSizeView: Bool = true
    var loadingState: LoadingState = .loaded("Enter link")
    var convertedModel: ConvertedModel? {
        didSet {
            article = convertedModel?.productProperties.article ?? ""
            print("Images urls: \(imageURLs.count)")
        }
    }
    var bagData: BagEditData = .init()
    var sizesData: [SizeData] = []
    var imageURLs: [URL] = []
    var article: String = ""
    // MARK: - Private properties

    private let networkController: NetworkController = .init()
    private let xlCreator: XLCreator = .init()
    private let modelHandler: ModelConverter = .init()


    func getDataFromURL(string: String) {
        currentLink = string
        showSizeView = false
        convertedModel = nil
        
        Task {
            do {
                let convertedModel: ConvertedModel = try await getConvertedModel(from: string)
                loadingState = .loaded("Converted model created")
                imageURLs = try await networkController.getImagesURLs(from: string)
                showSizeView = true

                switch itemType {
                case .bags:
                    bagData = .init(
                        fabricChinese: convertedModel.productProperties.fabricForBags,
                        strapsData: convertedModel.productProperties.straps
                    )
                case .cloth:
                    sizesData = getUniqueSizeData(from: convertedModel.itemsByColor)
                }

                self.convertedModel = convertedModel
            } catch {
                print(error)
            }
        }
    }


    func getConvertedModel(from urlString: String) async throws -> ConvertedModel {
        loadingState = .loading("Fetching data from 1688")
        let model: MainModel = try await networkController.getMainModel(from: urlString)

        loadingState = .loading("Converting model")
        let convertedModel: ConvertedModel = try await modelHandler.convert(from: model.data)

        return convertedModel
    }

    func createXLFile() {
        guard let convertedModel else { return }
        loadingState = .loading("Creating XL file")

        Task {
            switch itemType {
            case .bags:
                let bagModel: BagModel = createBagModel(from: convertedModel, bagData: bagData)
                xlCreator.createXLFile(from: bagModel, images: bagModel.images, id: String(convertedModel.id))

            case .cloth:
                let clothModel: ClothModel = createClothModel(from: convertedModel, sizeData: sizesData)
                xlCreator.createXLFile(from: clothModel, images: clothModel.images, id: String(convertedModel.id))

            }
            loadingState = .loaded("XL file was created")
        }
    }

    // MARK: - Testing
    func createTestJson() {
        currentLink = "testing"
        setupTestModelFromLocalJSON()
        testImagesURL()
    }
    func setupTestModelFromLocalJSON() {
        guard let path = Bundle.main.path(forResource: "bigJSON", ofType: "json") else { return }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let mainModel = try decoder.decode(MainModel.self, from: data)
            Task {
                let convertedModel = try await modelHandler.convert(from: mainModel.data)

                loadingState = .loaded("Converted model created")
                sizesData = getUniqueSizeData(from: convertedModel.itemsByColor)
                self.convertedModel = convertedModel
                showSizeView = true
            }
        } catch {
            print("Error in \(#function) - \(error.localizedDescription)")
            return
        }
    }


    func testImagesURL() {
        guard let path = Bundle.main.path(forResource: "diffAPI", ofType: "json") else { return }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let mainModel = try decoder.decode(New1688Images.self, from: data)
            imageURLs = mainModel.allURLStrings.compactMap { URL(string: $0) }
            print(imageURLs)
        } catch {
            print("Error in \(#function) - \(error.localizedDescription)")
            return
        }
    }
    func createBagModel(from data: ConvertedModel, bagData: BagEditData) -> BagModel {
        BagModel(
            title: data.title,
            images: data.mainImagesData,
            article: data.productProperties.article ?? String(data.id),
            articleAndColorSku: nil,
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

    func createClothModel(from data: ConvertedModel, sizeData: [SizeData]) -> ClothModel {
        var itemsByColor = data.itemsByColor
        updateSizeData(in: &itemsByColor, with: sizeData)

        return ClothModel(
            title: data.title,
            images: data.mainImagesData,
            article: data.productProperties.article ?? String(data.id),
            articleAndColorSku: nil,
            productName: "need name",
            price: data.price,
            itemsByColor: itemsByColor,
            weight: data.weight,
            compositionChinese: data.productProperties.fabricForBags ?? "",
            fabric: data.productProperties.fabricValueChinise ?? ""
        )
    }

    func updateSizeData(in items: inout [ItemByColor], with newSizeData: [SizeData]) {
        let sizeDataDict = Dictionary(grouping: newSizeData, by: { $0.sizeInfo.sizeLetter })

        for (itemIndex, item) in items.enumerated() {
            for (sizeIndex, sizeAndQuantity) in item.dataBySize.enumerated() {
                let letter = sizeAndQuantity.sizeData.sizeInfo.sizeLetter
                if let newSizeDataArray = sizeDataDict[letter], let newSizeData = newSizeDataArray.first {
                    items[itemIndex].dataBySize[sizeIndex].sizeData = newSizeData
                }
            }
        }
    }

    /// Get only uniq sizes from all items.
    func getUniqueSizeData(from items: [ItemByColor]) -> [SizeData] {
        var sets: Set<SizeData> = .init()

        for item in items {
            for sizeAndQuantity in item.dataBySize {
                sets.insert(sizeAndQuantity.sizeData)
            }
        }

        return Array(sets).sorted { $0.sizeInfo.sizeLetter.rawValue < $1.sizeInfo.sizeLetter.rawValue }
    }
}

enum ProductType: String, CaseIterable {
    case cloth = "Cloth"
    case bags = "Bags"

    var image: Image {
        switch self {
        case .cloth:
            Image(systemName: "tshirt.fill")
        case .bags:
            Image(systemName: "bags.fill")
        }
    }
}

enum LoadingState {
    case loading(String)
    case loaded(String)
}
