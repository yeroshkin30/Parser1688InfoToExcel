//
//  MainViews.swift
//  testJSON
//
//  Created by oleh yeroshkin on 20.06.2024.
//

import SwiftUI

struct MainView: View {
    @State var dataController: DataController = .init()
    @State var loadingState: LoadingState = .loaded("None")

    var body: some View {
        VStack {
            LoaderView(loadingState: dataController.loadingState)
            GetLinkView() { urlString in
                dataController.getDataFromURL(string: urlString)
            }
            Button { dataController.createTestJson() } label: { Text("Create test json")}

            switch dataController.itemTypes {
            case .bags:
                BagsPropertiesView(bagEditData: $dataController.bagData)
            case .cloth:
                SizePropertiesCreationView(sizeData: $dataController.sizesData)
            case .none:
                EmptyView()
            }

            if let _ = dataController.convertedModel, dataController.itemTypes != .none {
                Button { dataController.createXLFile() } label: {
                    Text("Create XL File")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue, in: RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)

            }
        }
        .padding()
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

#Preview {
    MainView() 
}

