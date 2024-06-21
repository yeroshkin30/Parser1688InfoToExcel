//
//  GetLinkView.swift
//  testJSON
//
//  Created by oleh yeroshkin on 20.06.2024.
//


import SwiftUI

struct GetLinkView: View {
    let onGetData: (String) -> Void

    @State private var linkString: String = ""

    var body: some View {
        VStack {
            TextField("Enter link", text: $linkString)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button { onGetData(linkString) } label: {
                Text("Get data from link")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue, in: RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)

        }
        .padding()
        .background(Color.gray, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    GetLinkView() { _ in }
}


