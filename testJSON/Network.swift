import AppKit


class NetworkController {

    let session = URLSession.shared

    let headers = [
        "x-rapidapi-key": "2ea9f0a3c2msh2669d86449795bcp1c453ajsn0b765c765b17",
        "x-rapidapi-host": "1688-product2.p.rapidapi.com"
    ]


    func getMainModel(for id: String) async throws -> MainModel {
        var urlRequest = URLRequest(url: URL(string: "https://1688-product2.p.rapidapi.com/1688/v2/item_detail?item_id=\(String(id))")!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = 10
        urlRequest.cachePolicy = .useProtocolCachePolicy


        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw Errors.dataNotFound
        }
        let mainModel = try JSONDecoder().decode(MainModel.self, from: data)

        return mainModel
    }
}


func getImages(from urls: [URL]) async throws -> [NSImage] {
    var images: [NSImage] = []
    for url in urls {
        let image = try await getImage(from: url)
        images.append(image)
    }

    return images
}

func getImage(from url: URL) async throws -> NSImage {
    do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            throw Errors.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            print("HTTP error: \(httpResponse.statusCode)")
            throw Errors.httpError(code: httpResponse.statusCode)
        }

        guard let image = NSImage(data: data) else {
            print("Invalid image data")
            throw Errors.invalidImageData
        }

        return image
    } catch {
        print("Failed to get image from \(url): \(error)")
        throw error
    }
}

enum Errors: Error {
    case imageNotFound
    case invalidResponse
    case httpError(code: Int)
    case invalidImageData
    case dataNotFound
    case photoDataNotFound
    case cantCreateImageFromData
}
