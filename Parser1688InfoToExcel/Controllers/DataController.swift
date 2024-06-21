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

    func getDataFromURL(string: String) {
        currentLink = string
//        Task {
//            let model: MainModel = try await networkController.getMainModel(from: string)
//            loadingState = .loading("Converting model")
//            let convertedModel: DataModelConverted = try await modelHandler.convert(from: model.data)
//            loadingState = .loaded("Converted model created")
//            bagData = .init(
//                fabricChinese: convertedModel.productProperties.fabricForBags,
//                strapsData: convertedModel.productProperties.straps
//            )
//            itemTypes = .bags
//            self.convertedModel = convertedModel
//        }
        setupModels()
    }

    func createXLFile() {
        guard let convertedModel else { return }
        let bagModel: BagModel = createBagModel(from: convertedModel, bagData: bagData)

        loadingState = .loading("Creating XL file")
        Task {
            xlCreator.createExcelFile(from: bagModel, images: bagModel.images, id: String(convertedModel.id))
            loadingState = .loaded("XL file was craeted")
        }
    }

    func setupModels() {

        guard let path = Bundle.main.path(forResource: "itemJSON", ofType: "json") else { return }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let mainModel = try decoder.decode(MainModel.self, from: data)
            Task {
                let convertedModel = try await modelHandler.convert(from: mainModel.data)
                loadingState = .loaded("Converted model created")
                bagData = .init(
                    fabricChinese: convertedModel.productProperties.fabricForBags,
                    strapsData: convertedModel.productProperties.straps
                )
                itemTypes = .bags
                self.convertedModel = convertedModel
            }
        } catch {
            print("Error in \(#function) - \(error.localizedDescription)")
            return
        }
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
