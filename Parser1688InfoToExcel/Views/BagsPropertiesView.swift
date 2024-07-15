//
//  BagsPropertiesView.swift
//  testJSON
//
//  Created by Oleh Yeroshkin on 21.06.2024.
//

import SwiftUI

struct BagsPropertiesView: View {
    @Binding var bagEditData: BagEditData
    @State private var maxLabelWidth: CGFloat?

    var body: some View {
        Form {
            CustomTextField(
                inputText: $bagEditData.bagSize,
                title: "Bag size",
                value: "",
                maxLabelWidth: $maxLabelWidth
            )
            Divider()
            CustomTextField(
                inputText: $bagEditData.fabric,
                title: "Fabric:",
                value: bagEditData.fabricChinese,
                maxLabelWidth: $maxLabelWidth
            )
            Divider()
            CustomTextField(
                inputText: $bagEditData.straps,
                title: "Straps",
                value: bagEditData.strapsData,
                maxLabelWidth: $maxLabelWidth
            )
        }
        .padding()
        .onPreferenceChange(MaxWidthPreferenceKey.self) { width in
            maxLabelWidth = max(maxLabelWidth ?? 0, width)
        }
        .frame(width: 300)
    }
}
// Define a PreferenceKey to store the maximum width
struct MaxWidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct CustomTextField: View {
    @Binding var inputText: String
    let title: String
    let value: String?
    @Binding var maxLabelWidth: CGFloat?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Value: \(value ?? "")")
                .font(.system(size: 16))
                .foregroundColor(.black)

            TextField(text: $inputText) {
                Text(title)
                    .background(GeometryReader { geometry in
                        Color.clear.preference(key: MaxWidthPreferenceKey.self, value: geometry.size.width)
                    })
                    .frame(width: maxLabelWidth, alignment: .leading)
            }
            .textFieldStyle(.roundedBorder)
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
    }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

