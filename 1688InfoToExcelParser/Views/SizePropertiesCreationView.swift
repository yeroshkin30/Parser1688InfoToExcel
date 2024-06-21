//
//  SizePropertiesCreationView.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 20.06.2024.
//

import SwiftUI

struct SizePropertiesCreationView: View {
    @State var sizeData: [SizeData] = [
        .init(sizeInfo: .init(sizeChinese: "S")),
        .init(sizeInfo: .init(sizeChinese: "XL")),
        .init(sizeInfo: .init(sizeChinese: "XXL"))
    ]

    let propertiesName =  [
        "Size",
        "Product length",
        "Shoulders length",
        "Bust",
        "Waist",
        "Hips"
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(propertiesName, id: \.self) { propName in
                    Text(propName)
                        .frame(width: 100)
                }

            }
            VStack {
                ForEach($sizeData) { sizeData in
                    SizeStackViews(sizeData: sizeData)
                }
            }
            Button { } label: {
                Text("CreateSizeData")
            }
        }
        .padding()
    }

    func getStrings(from model: SizeProperties) -> [String] {
        let mirror = Mirror(reflecting: model)

        return mirror.children.compactMap { $0.label }
    }
}

#Preview {
    SizePropertiesCreationView()
}


struct SizeStackViews: View {
    @Binding var sizeData: SizeData

    var body: some View {
        HStack {
            Text(sizeData.sizeInfo.sizeLetter.value)
                .frame(width: 100)
            TextField("", text: $sizeData.sizeProperties.productLength)
            TextField("", text: $sizeData.sizeProperties.shoulderLength)
            TextField("", text: $sizeData.sizeProperties.bust)
            TextField("", text: $sizeData.sizeProperties.waist)
            TextField("", text: $sizeData.sizeProperties.hips)
        }
    }
}




struct SizeBinding {
    var productLength: String = ""
    var shoulderLength: String = ""
    var bust: String = ""
    var waist: String = ""
    var hips: String = ""
    var sleeve: String = ""
}
