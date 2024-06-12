//
//  ViewController.swift
//  testJSON
//
//  Created by oleh yeroshkin on 10.06.2024.
//

import Cocoa

final class ViewController: NSViewController {
    private let networkController: NetworkController = .init()
    private let xlCreator: XLCreator = .init()
    private let textField: NSTextField = .init(frame: NSMakeRect(200, 200, 60, 30))
    private let button: NSButton = .init()

    // MARK: - Private properties


    // MARK: - Lifecycle
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 800, height: 300))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private properties

private extension ViewController {
    func setup() {
        setupTestField()
        setupButton()
    }

    func setupTestField() {
        textField.frame = NSMakeRect(50, 50, 600, 60)
        textField.placeholderString = "Add link"
        view.addSubview(textField)
    }

    func setupButton() {
        button.frame = NSMakeRect(200, 200, 60, 30)
        button.title = "Press me"
        view.addSubview(button)
        button.action = #selector(buttonTap)
    }

    @objc func buttonTap() {
        let link = textField.stringValue
        Task {
            try? await getModels(from: link)
        }
    }

    func getModels(from urlString: String) async throws {
        guard let idNumber: String = getIDNumberFromURL(from: urlString) else { return }

        let mainModel = try await networkController.getMainModel(for: idNumber)
        let convertedModel = try await mainModel.data.convert(from: mainModel.data)
        let itemModels = createItemModels(from: convertedModel)
        xlCreator.createExcelFile(with: itemModels, id: idNumber)
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


func createItemModels(from data: DataModelConverted) -> [Model]{
    var models: [Model] = []

    for itemType in data.itemTypes {
        let model = Model(
            title: data.title,
            images: data.images,
            article: data.productProperties.article ?? String(data.id),
            sku: "\(data.productProperties.article ?? String(data.id)) + color",
            productName: "need name",
            color: itemType.color,
            size: itemType.size,
            sizeEnum: itemType.sizeEnum,
            price: data.price,
            quantity: itemType.quantity,
            productLength: nil,
            bustSize: nil,
            waistSize: nil,
            sleevelength: nil,
            weight: data.weight,
            fabric: data.productProperties.fabricName ?? "no fabric"
        )

        models.append(model)
    }

    return models
}
