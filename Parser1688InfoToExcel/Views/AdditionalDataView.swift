//
//  AdditionalDataView.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 13.07.2024.
//

import SwiftUI


struct AdditionalDataView: View {
    @Binding var brandName: String

    var body: some View {
        HStack {
            Text("Brand name")
                .font(.headline)
            TextField("", text: $brandName)
                .frame(width: 100)
        }
  }
}

#Preview {
    AdditionalDataView(brandName: .constant("d"))
}

