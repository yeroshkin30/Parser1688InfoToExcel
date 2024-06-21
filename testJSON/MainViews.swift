//
//  MainViews.swift
//  testJSON
//
//  Created by oleh yeroshkin on 20.06.2024.
//

import SwiftUI

struct MainViews: View {
    @State var loadingState: LoadingState = .loaded("None")
    @State var bagEditData: BagEditData = .init()
    @State var sizesData: [SizeData] = []

    private let networkController: NetworkController = .init()
    private let xlCreator: XLCreator = .init()
    private let modelHandler: ModelHandler = .init()

    init() {
        setupModels()
    }

    var body: some View {
        VStack {

            LoaderView(loadingState: loadingState)
            GetLinkView() { urlString in
//                getDataFromURL(string: urlString)
                setupModels()
            }

            if let bagEditData {
                BagsPropertiesView(bagEditData: $bagEditData)
            }

            if let sizesData {
                SizePropertiesCreationView(sizeData: sizesData)
            }
        }
        .padding()
    }

    func getDataFromURL(string: String) {
        Task {
            let model: MainModel = try await networkController.getMainModel(from: string)
            loadingState = .loading("Converting model")
            let convertedModel: DataModelConverted = try await ModelHandler().convert(from: model.data)
            loadingState = .loaded("Converted model created")
//            sizesData = convertedModel.productProperties.sizesChinese?.map ( { SizeData(sizeInfo: .init(sizeChinese: $0)) })
            bagEditData = .init()
        }
    }


    func setupModels() {

        guard let path = Bundle.main.path(forResource: "bigJSON", ofType: "json") else { return }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let mainModel = try decoder.decode(MainModel.self, from: data)
            Task {
                let convertedModel = try await modelHandler.convert(from: mainModel.data)
//                sizesData = convertedModel.productProperties.sizesChinese?.map ( { SizeData(sizeInfo: .init(sizeChinese: $0)) })
                loadingState = .loading("Loading")
//                bagEditData = true
            }
        } catch {
            print("Error in \(#function) - \(error.localizedDescription)")
            return
        }
    }
}

struct LoaderView: View {
    let loadingState: LoadingState

    var body: some View {
        switch loadingState {
        case .loading(let message):
            HStack(spacing: 10) {
                ProgressView()
                Text(message)
                    .font(.headline)
            }
            .padding()
        case .loaded(let message):
            Text(message)
                .font(.headline)
                .padding()
        }
    }
}

enum LoadingState {
    case loading(String)
    case loaded(String)
}

#Preview {
    MainViews() 
}

