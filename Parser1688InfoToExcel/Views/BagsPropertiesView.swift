//
//  BagsPropertiesView.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 21.06.2024.
//

import SwiftUI

struct BagsPropertiesView: View {
    @Binding var bagEditData: BagEditData

    var body: some View {
        
        VStack(spacing: 15) {
            Form {
                CustomTextField(inputText: $bagEditData.bagSize, title: "Bag size", value: "No data")
                CustomTextField(inputText: $bagEditData.fabric, title: "Fabric:", value: bagEditData.fabricChinese)
                CustomTextField(inputText: $bagEditData.straps, title: "Straps", value: bagEditData.strapsData)
            }
        }
        .padding()
        .frame(width: 400)
    }
}



struct CustomTextField: View {
    @Binding var inputText: String
    let title: String
    let value: String?

    var body: some View {
        VStack {
                Text(value ?? "")
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                TextField(text: $inputText, prompt: Text(title)) {
                    Text(title)
                }
                .textFieldStyle(.roundedBorder)
        }
        .padding()
        .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10))
    }
}

struct BagEditData: Identifiable {
    let id: UUID = .init()
    var fabricChinese: String? = nil
    var strapsData: String? = nil
    var bagSize: String = ""
    var fabric: String = ""
    var straps: String = ""
}


private struct Preview: View {

    @State private var state: BagEditData = .init()

    var body: some View {
        BagsPropertiesView(bagEditData: $state)

    }
}

#Preview {
    Preview()
}

