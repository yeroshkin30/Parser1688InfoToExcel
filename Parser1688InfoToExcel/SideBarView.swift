//
//  SideBarView.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 14.07.2024.
//

import SwiftUI

struct SideBarView: View {

    @State var dataController: DataController = .init()

    var body: some View {
        TabView {

            MainView(dataController: $dataController)
                .tabItem {
                    Label("Data", systemImage: "book")
                        .font(.title2)
                }
            PhotosDownloadView(
                photosURL: $dataController.imageURLs,
                productArticle: dataController.article
            )
            .tabItem {
                Label("Photos", systemImage: "photo")
                    .font(.title2)
            }
        }
//        NavigationSplitView {
//            List {
//                NavigationLink(destination: MainView(dataController: $dataController)) {
//                }
//                NavigationLink(
//                    destination: PhotosDownloadView(
//                        photosURL: $dataController.imageURLs,
//                        productArticle: dataController.convertedModel?.productProperties.article ?? ""
//                    )
//                ) {
//                }
//            }
//            .navigationTitle("Learn")
//        }
    }
}

