//
//  App.swift
//  testJSON
//
//  Created by oleh yeroshkin on 20.06.2024.
//

import Foundation


import SwiftUI

@main
struct _688DetailsApp: App {
    var body: some Scene {
        WindowGroup {
            MainViews()
        }
    }
}


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
