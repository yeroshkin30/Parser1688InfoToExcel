//
//  MainViews.swift
//  testJSON
//
//  Created by oleh yeroshkin on 20.06.2024.
//

import SwiftUI

struct MainView: View {
    @Binding var dataController: DataController

    var body: some View {
        VStack {
            productSegmentControl
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top)
                .frame(width: 300)

            LoaderView(loadingState: dataController.loadingState)
                .frame(height: 40)
                .backgroundStyle(LinearGradient(
                    gradient: Gradient(colors: [.red, .green]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
            LinkInputView() { urlString in
                dataController.getDataFromURL(string: urlString)
            }
            Button { dataController.createTestJson() } label: { Text("Create test json")}

            if dataController.showSizeView {
                switch dataController.itemType {
                case .bags:
                    BagsPropertiesView(bagEditData: $dataController.bagData)
                case .cloth:
                    SizePropertiesCreationView(sizeData: $dataController.sizesData)
                }
            }
            Spacer()

            if let _ = dataController.convertedModel, dataController.showSizeView {
                createXLFileButton
            }

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors:  [
                    Color(red: 1.0, green: 0.37, blue: 0.43), // #FF5F6D
                    Color(red: 1.0, green: 0.44, blue: 0.6), // #FF5F6D
                    Color(red: 1.0, green: 0.77, blue: 0.44)  // #FFC371
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    @ViewBuilder
    var productSegmentControl: some View {
        Picker("", selection: $dataController.itemType) {
            ForEach(ProductType.allCases, id: \.self) { type in
                HStack {
                    Text(type.rawValue)
                }.tag(type)
            }
        }
    }

    var createXLFileButton: some View {
        Button {
            dataController.createXLFile()
        } label: {
            Text("Create XL File")
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue, in: RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
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
    MainView(dataController: .constant(.init()))
}

