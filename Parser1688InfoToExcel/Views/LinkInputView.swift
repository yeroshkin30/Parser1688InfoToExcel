//
//  GetLinkView.swift
//  testJSON
//
//  Created by oleh yeroshkin on 20.06.2024.
//


import SwiftUI

struct LinkInputView: View {
    let onGetData: (String) -> Void

    @State private var linkString: String = ""

    var body: some View {
        HStack {
            TextEditor(text: $linkString)
                .frame(width: 400)
                .frame(minHeight: 30)
                .fixedSize()
                .font(.system(.subheadline))
            Button { onGetData(linkString) } label: {
                Text("Get data from link")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue, in: Capsule())
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    LinkInputView() { _ in }
}


