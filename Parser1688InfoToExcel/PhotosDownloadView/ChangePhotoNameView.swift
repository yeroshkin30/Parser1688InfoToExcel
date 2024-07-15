//
//  SavePhotoView.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 14.07.2024.
//

import SwiftUI

struct ChangePhotoNameView: View {
    @State var article: String
    let onSaveButtonTap: (_ name: String) -> Void
    @State private var photoName: String = ""
    @State private var selectedValue = "Select a name"

    let predefinedValues = ["_1", "_2", "_3"]

    var body: some View {
        VStack {
            articleNameView
            photoNamesButtonsStack
            photoNameView
            savePhotoButton
                .buttonStyle(.plain)
        }
    }

    // MARK: - Views

    var savePhotoButton: some View {
        Button {
            onSaveButtonTap(article + photoName)
        } label: {
            Text("Save Photo")
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue, in: RoundedRectangle(cornerRadius: 10))
        }
        .disabled(photoName.isEmpty)
    }

    var articleNameView: some View {
        VStack {
            HStack {
                Text("Article:")
                TextField("", text: $article)
                    .frame(width: 150)
            }
        }
    }
    var photoNameView: some View {
        VStack {
            HStack {
                Text("Name:")
                TextField("", text: $photoName)
                    .frame(width: 150)
            }
            Text("\(article) \(photoName)")
                .font(.title)
        }
    }

    var photoNamesButtonsStack: some View {
        HStack {
            ForEach(predefinedValues, id: \.self) { value in
                Button(action: {
                    photoName += value
                }) {
                    Text(value)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    ChangePhotoNameView(article: "ns1111") { name in }
}
