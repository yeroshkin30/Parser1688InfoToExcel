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
            CustomTextField(inputText: $bagEditData.bagSize, title: "Bag size")
            CustomTextField(inputText: $bagEditData.fabric, title: "Fabric:")
            CustomTextField(inputText: $bagEditData.zippers, title: "Buttons, zippers, pockets: ")
            Button { } label: {
                Text("Create bag data")
            }
        }
        .padding()
//        .background(.gray)
        .frame(width: 400)
    }
}



struct BagEditData: Identifiable {
    let id: UUID = .init()
    var bagSize: String = ""
    var fabric: String = ""
    var zippers: String = ""
}

struct CustomTextField: View {
    @Binding var inputText: String
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(.black)
            TextField(title, text: $inputText)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
        .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 10))
    }
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

