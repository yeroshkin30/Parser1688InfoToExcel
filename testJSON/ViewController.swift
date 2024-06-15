//
//  ViewController.swift
//  testJSON
//
//  Created by oleh yeroshkin on 10.06.2024.
//

import Cocoa

final class ViewController: NSViewController {

    private let mainView: MainView = .init()
    private let networkController: NetworkController = .init()
    private let xlCreator: XLCreator = .init()
    var convertedModel: DataModelConverted?
    var sizeData: [SizeData] = []
    // MARK: - Private properties


    // MARK: - Lifecycle
    override func loadView() {
        self.view = mainView
        mainView.frame = NSRect(x: 0, y: 0, width: 1000, height: 600)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private properties

private extension ViewController {
    func setup() {
//        setupTextField()
//        setupButton()
        setupMainView()
        setupModels()
    }

    func setupMainView() {
        mainView.onEvent = { [unowned self] event in
            switch event {
            case .linkButtonTapped(let link):
                Task {
                    do {
                        convertedModel =  try await getModels(from: link)
                        if let convertedModel {
                            let allSizes: Set<Size> = Set(convertedModel.itemTypes.map { $0.sizeEnum })
                            let sizes = Array(allSizes).sorted { $0.rawValue < $1.rawValue }
                            mainView.setupSizeCreationView(with: sizes)
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            case .sizeButtonWasTaped(let sizeData):
                self.sizeData = sizeData
            case .createXLFile:
                guard let convertedModel else {
                    print("No converted data")
                    return
                }
                createXLFile(with: convertedModel, sizeData: sizeData)
            }
        }
    }

    func getModels(from urlString: String) async throws -> DataModelConverted {
        guard let idNumber: String = getIDNumberFromURL(from: urlString) else {
            throw CustomErrors.noId
        }

        let mainModel = try await networkController.getMainModel(for: idNumber)
        let convertedModel = try await mainModel.data.convert(from: mainModel.data)

        return convertedModel
    }

    func createXLFile(with data: DataModelConverted, sizeData: [SizeData]) {
        let models = createItemModels(from: data, sizesData: sizeData)

        xlCreator.createExcelFile(
            with: models,
            images: data.images,
            imageByColor: data.imtePhotoByColor,
            id: String(data.id)
        )
    }

    func setupModels() {

        guard let path = Bundle.main.path(forResource: "itemJSON", ofType: "json") else { return }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let mainModel = try decoder.decode(MainModel.self, from: data)
            Task {
                let converted = try await mainModel.data.convert(from: mainModel.data)
                let allSizes: Set<Size> = Set(converted.itemTypes.map { $0.sizeEnum })
                let sizes = Array(allSizes).sorted { $0.rawValue < $1.rawValue }
//                mainView.setupSizeCreationView(with: sizes) { [weak self] sizeData in
//                    guard let self else { return }
//                    let models = createItemModels(from: converted, sizesData: sizeData)
//                    xlCreator.createExcelFile(
//                        with: models,
//                        images: converted.images,
//                        imageByColor: converted.imtePhotoByColor,
//                        id: String(converted.id)
//                    )
//                }
            }
        } catch {
            print("Error in \(#function) - \(error.localizedDescription)")
            return
        }
    }


    // Get ID
    func getIDNumberFromURL(from urlString: String) -> String? {
        let pattern = #"offer/(\d+)\.html"#

        do {
            // Create a regular expression object
            let regex = try NSRegularExpression(pattern: pattern)

            // Search for matches in the URL string
            let results = regex.matches(in: urlString, range: NSRange(urlString.startIndex..., in: urlString))

            if let match = results.first, let range = Range(match.range(at: 1), in: urlString) {
                let number = String(urlString[range])
                print("Extracted number: \(number)")
                return number
            } else {
                print("No match found")
                return nil
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
}


func createItemModels(from data: DataModelConverted, sizesData: [SizeData]) -> [Model]{
    var models: [Model] = []

    for itemType in data.itemTypes {
        let sizeData = sizesData.first { $0.sizeValue == itemType.sizeEnum.value }!
        let model = Model(
            title: data.title,
            images: data.images,
            article: data.productProperties.article ?? String(data.id),
            sku: "\(data.productProperties.article ?? String(data.id)) + color",
            productName: "need name",
            colorChina: itemType.color,
            colorEng: itemType.colorEng,
            size: itemType.size,
            sizeEnum: itemType.sizeEnum,
            price: data.price,
            quantity: itemType.quantity,
            productLength: sizeData.productLength,
            shoulders: sizeData.shoulderLength,
            bustSize: sizeData.bust,
            waistSize: sizeData.waist,
            hips: sizeData.hips,
            sleevelength: sizeData.sleeve,
            weight: data.weight,
            fabric: data.productProperties.fabricValueChinise ?? "Error"
        )

        models.append(model)
    }

    return models
}


enum CustomErrors: Error {
    case noId
}
