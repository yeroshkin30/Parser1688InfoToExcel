////
////  ViewController.swift
////  testJSON
////
////  Created by oleh yeroshkin on 10.06.2024.
////
//
//
//
//
//
//
//import Cocoa
//
//final class ViewController: NSViewController {
//
//    private let mainView: MainView = .init()
//    private let networkController: NetworkController = .init()
//    private let xlCreator: XLCreator = .init()
//    var convertedModel: DataModelConverted?
//    var sizeData: [SizeData] = [.init(sizeInfo: .init(sizeChinese: "S"))]
//    // MARK: - Private properties
//
//
//    // MARK: - Lifecycle
//    override func loadView() {
//        self.view = mainView
//        mainView.frame = NSRect(x: 0, y: 0, width: 1000, height: 600)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        setup()
//    }
//}
//var newLink: String = .init()
//// MARK: - Private properties
//
//private extension ViewController {
//    func setup() {
//        setupMainView()
//        setupModels()
//    }
//
//    func setupMainView() {
//        mainView.onEvent = { [unowned self] event in
//            switch event {
//            case .linkButtonTapped(let link):
//                newLink = link
//                Task {
//                    do {
//                        convertedModel =  try await getModels(from: link)
//                        if let convertedModel {
//                            let sizeInfos: [SizeInfo] = SizeInfo.getUniqueSizeInfos(from: convertedModel.itemTypes)
//                            mainView.setupSizeCreationView(with: sizeInfos)
//                        }
//                    }
//                    catch {
//                        print(error)
//                    }
//                }
//            case .sizeButtonWasTaped(let sizeData):
//                self.sizeData = sizeData
//            case .createXLFile:
//                guard let convertedModel else {
//                    print("No converted data")
//                    return
//                }
//                createXLFile(with: convertedModel, sizeData: sizeData)
//            }
//        }
//    }
//
//    func getModels(from urlString: String) async throws -> DataModelConverted {
//        guard let idNumber: String = getIDNumberFromURL(from: urlString) else {
//            throw CustomErrors.noId
//        }
//
//        let mainModel = try await networkController.getMainModel(for: idNumber)
//        let convertedModel = try await mainModel.data.convert(from: mainModel.data)
//
//        return convertedModel
//    }
//
//    func createXLFile(with data: DataModelConverted, sizeData: [SizeData]) {
//        let models = createItemModels(from: data, sizesData: sizeData)
//
//        xlCreator.createExcelFile(
//            with: models,
//            images: data.images,
//            imageByColor: data.imtePhotoByColor,
//            id: String(data.id)
//        )
//    }
//
//    func setupModels() {
//
//        guard let path = Bundle.main.path(forResource: "bigJSON", ofType: "json") else { return }
//
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let decoder = JSONDecoder()
//            let mainModel = try decoder.decode(MainModel.self, from: data)
//            Task {
//                let convertedModel = try await mainModel.data.convert(from: mainModel.data)
//                let sizeInfos: [SizeInfo] = SizeInfo.getUniqueSizeInfos(from: convertedModel.itemTypes)
//                mainView.setupSizeCreationView(with: sizeInfos)
//                self.convertedModel = convertedModel
//            }
//        } catch {
//            print("Error in \(#function) - \(error.localizedDescription)")
//            return
//        }
//    }
//
//
//    // Get ID
//    func getIDNumberFromURL(from urlString: String) -> String? {
//        let pattern = #"offer/(\d+)\.html"#
//
//        do {
//            // Create a regular expression object
//            let regex = try NSRegularExpression(pattern: pattern)
//
//            // Search for matches in the URL string
//            let results = regex.matches(in: urlString, range: NSRange(urlString.startIndex..., in: urlString))
//
//            if let match = results.first, let range = Range(match.range(at: 1), in: urlString) {
//                let number = String(urlString[range])
//                print("Extracted number: \(number)")
//                return number
//            } else {
//                print("No match found")
//                return nil
//            }
//        } catch {
//            print("Invalid regex: \(error.localizedDescription)")
//            return nil
//        }
//    }
//}
////
////
////func createItemModels(from data: DataModelConverted, sizesData: [SizeData]) -> [Model]{
////    var models: [Model] = []
////
//////    for itemBycolor in data.itemsByColor {
//////        let sizeData = sizesData.first { $0.sizeInfo.sizeLetter == itemBycolor.sizeInfo.sizeLetter } ?? .init(sizeInfo: itemBycolor.sizeInfo)
//////        let model = Model(
//////            title: data.title,
//////            images: data.images,
//////            article: data.productProperties.article ?? String(data.id),
//////            sku: "\(data.productProperties.article ?? String(data.id)) \(itemBycolor.colorEng ?? "")",
//////            productName: "need name",
//////            colorChina: itemBycolor.color,
//////            colorEng: itemBycolor.colorEng ?? "",
//////            sizeInfo: itemBycolor.sizeInfo,
//////            price: data.price,
//////            quantity: itemBycolor.quantity,
//////            productLength: sizeData.productLength,
//////            shoulders: sizeData.shoulderLength,
//////            bustSize: sizeData.bust,
//////            waistSize: sizeData.waist,
//////            hips: sizeData.hips,
//////            sleevelength: sizeData.sleeve,
//////            weight: data.weight,
//////            fabric: data.productProperties.fabricValueChinise ?? "Error"
//////        )
//////
//////        models.append(model)
//////    }
////
////    return models
////}
//
//
//enum CustomErrors: Error {
//    case noId
//}
