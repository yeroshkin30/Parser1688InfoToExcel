//
//  PhotosDownloadView.swift
//  Parser1688InfoToExcel
//
//  Created by Oleh Yeroshkin on 14.07.2024.
//
import AppKit
import SwiftUI


struct PhotosDownloadView: View {
    @Binding var photosURL: [URL]
    let productArticle: String
    @State private var selectedPhotoData: ImageData?
    private let imageSaver: ImageSaveController = .init()

    var body: some View {
        VStack {
            HStack {
                SelectedPhotoView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                ChangePhotoNameView(article: productArticle) { name in
                    guard let selectedPhotoData else { return }
                    imageSaver.saveImage(image: selectedPhotoData.image,name: name, article: productArticle)
                }
            }

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(photosURL, id: \.self) { url in
                        ImageLoaderView(url: url ,onImageTap: { imageData in
                            selectedPhotoData = imageData
                        })
                    }
                }
                .padding(.horizontal)
            }
            .padding(20)
            .background(.gray.opacity(0.3))
            .frame(height: 150)
        }
    }



    @ViewBuilder
    var SelectedPhotoView: some View {
        VStack(alignment: .leading) {
            if let selectedPhotoData {
                Text("Selected Photo")
                    .font(.largeTitle)
                Text("Photo size: \(Int(selectedPhotoData.width))x\(Int(selectedPhotoData.height))")
                    .font(.headline)
                Image(nsImage: selectedPhotoData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(.gray)
                    .padding(.top)
            } else {
                ProgressView()
            }
        }
    }
}

struct ImageDownloadView: View {
    let url: URL
    let onImageTap: (Image?) -> Void
    @State private var image: Image?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .failure:
                Image(systemName: "photo")
                    .font(.largeTitle)
            case .success(let image):
                image
                    .resizable()
                    .onAppear {
                        self.image = image
                    }
            default:
                ProgressView()
            }
        }
        .frame(width: 70, height: 70)
        .onTapGesture {
            onImageTap(image)
        }
        Text("ImageSize")
    }
}

struct ImageLoaderView: View {
    let url: URL
    let onImageTap: (ImageData?) -> Void

    @State private var loadingState: ImageLoadingState = .failure
    @State private var imageTask: Task<Void, Never>?
    @State private var imageData: ImageData?

    var body: some View {
        VStack {
            switch loadingState {
            case .loading:
                ProgressView()
            case .success(let image):
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(.gray)
            case .failure:
                Image(systemName: "photo")
                    .font(.largeTitle)            }

        }
        .onAppear {
           downloadImage()
        }
        .onDisappear {
            imageTask?.cancel()
            imageTask = nil
        }
        .onTapGesture {
            onImageTap(imageData)
        }
    }

    func downloadImage() {
        imageTask = Task {
            defer { imageTask = nil }
            var data: Data = .init()

            do {
                data = try await getImageData(from: url)
            } catch {
                print(error)
            }

            if !Task.isCancelled {
                guard let image = NSImage(data: data) else {
                    loadingState = .failure
                    return
                }

                loadingState = .success(image)
                imageData = .init(
                    image: image,
                    width: image.size.width,
                    height: image.size.height,
                    weight: String(data.count)
                )
            }

            imageTask = nil
        }
    }

    enum ImageLoadingState {
        case loading
        case success(NSImage)
        case failure
    }
}

struct ImageData {
    var image: NSImage
    var width: CGFloat
    var height: CGFloat
    var weight: String
}
//
//#Preview {
//    PhotosDownloadView(photosURL: urlss)
//}
let testPhotos: [Image] = [
    Image(.photo1),
    Image(.photo1),
    Image(.photo2),
    Image(.photo3),
    Image(.photo1),
    Image(.photo1),
    Image(.photo2),
    Image(.photo3),
    Image(.photo1),
    Image(.photo1),
    Image(.photo2),
    Image(.photo3),
    Image(.photo1),
    Image(.photo1),
    Image(.photo2),
    Image(.photo3)
]


let urlss =  [
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN01gCGNH21ks3IPXrGYl_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN01ywrp691ks3TN40xTW_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN01t5epQf1ks3SqXAlIu_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN01sbKMVC1ks3IQIgtxO_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN0188srYW1ks3IJgIXZM_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN01GKpyQd1ks3IKutlTH_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN0154pGpL1ks3KNfpz04_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN01f344TD1ks3IORiyBz_!!2210260454738-0-cib.jpg")!,
    URL(string:"https://cbu01.alicdn.com/img/ibank/O1CN01tnQUwi1ks3KOSfoUv_!!2210260454738-0-cib.jpg")!
]
