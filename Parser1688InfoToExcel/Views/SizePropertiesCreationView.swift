//
//  SizePropertiesCreationView.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 20.06.2024.
//

import SwiftUI

struct SizePropertiesCreationView: View {
    @Binding var sizeData: [SizeData]

    let propertiesName =  [
        "Size",
        "Product length",
        "Shoulders length",
        "Bust",
        "Waist",
        "Hips",
        "Sleeve"
    ]

    var body: some View {

        VStack(alignment: .leading) {

            let columnWidth: CGFloat = 100

            HStack(spacing: 10) {
                ForEach(propertiesName, id: \.self) { propName in
                    Text(propName)
                        .frame(width: columnWidth)
                        .padding(.vertical, 5)
                        .background(Color.gray, in: RoundedRectangle(cornerRadius: 15))
                }
            }
            VStack {
                ForEach($sizeData) { sizeDataSingle in
                    SizeStackViews(sizeData: sizeDataSingle, columnWidth: columnWidth)
                }
            }
            Button {
                // Your action here
            } label: {
                Text("Create Size Data")
            }
        }
        .padding()
        .background(.pink.opacity(0.2))
    }
}

struct SizeStackViews: View {
    @Binding var sizeData: SizeData
    var columnWidth: CGFloat

    var body: some View {
        HStack(spacing: 10) {
            Text(sizeData.sizeInfo.sizeLetter.value)
                .frame(width: columnWidth)
            TextField("Product length", text: $sizeData.sizeProperties.length)
                .frame(width: columnWidth)
            TextField("Shoulders length", text: $sizeData.sizeProperties.shoulder)
                .frame(width: columnWidth)
            TextField("Bust", text: $sizeData.sizeProperties.bust)
                .frame(width: columnWidth)
            TextField("Waist", text: $sizeData.sizeProperties.waist)
                .frame(width: columnWidth)
            TextField("Hips", text: $sizeData.sizeProperties.hips)
                .frame(width: columnWidth)
            TextField("Hips", text: $sizeData.sizeProperties.sleeve)
                .frame(width: columnWidth)
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
