import AppKit


class NetworkController {

    private let session: URLSession
    private let headers = [
        "x-rapidapi-key": "2ea9f0a3c2msh2669d86449795bcp1c453ajsn0b765c765b17",
        "x-rapidapi-host": "1688-product2.p.rapidapi.com"
    ]

    // Jurist acc
//    let headers = [
//        "x-rapidapi-key": "6c9d706434mshfee7aa859ff0bdbp1e5837jsn8156908f1c9a",
//        "x-rapidapi-host": "1688-product2.p.rapidapi.com"
//    ]

    // erh acc
//    let headers = [
//        "x-rapidapi-key": "aad9606530msh49a540a057765d4p1385c5jsnb5950c2e1466",
//        "x-rapidapi-host": "1688-product2.p.rapidapi.com"
//    ]

    // svob acc
//    let headers = [
//        "x-rapidapi-key": "58390e5047mshdde8016dac6efeap104fbcjsn53165a6e1f8d",
//        "x-rapidapi-host": "1688-product2.p.rapidapi.com"
//    ]

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 150 * 1024 * 1024,
            diskPath: "customCache"
        )
        configuration.requestCachePolicy = .useProtocolCachePolicy

        self.session =  URLSession(configuration: configuration)
    }

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

        // Check if the response was from cache
               if let userInfo = httpResponse.value(forHTTPHeaderField: "X-Cache-Status") {
                   print("Cache Status: \(userInfo)")
               }

        let mainModel = try JSONDecoder().decode(MainModel.self, from: data)

        return mainModel
    }

    func getMainModel(from urlString: String) async throws -> MainModel {
        guard let id = getIDNumberFromURL(from: urlString) else {
            throw Errors.cantGetIDFromURL
        }

        var urlRequest = URLRequest(url: URL(string: "https://1688-product2.p.rapidapi.com/1688/v2/item_detail?item_id=\(String(id))")!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = 10
        urlRequest.cachePolicy = .useProtocolCachePolicy

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw Errors.dataNotFound
        }

        // Check if the response was from cache
        if let userInfo = httpResponse.value(forHTTPHeaderField: "X-Cache-Status") {
            print("Cache Status: \(userInfo)")
        }

        let mainModel = try JSONDecoder().decode(MainModel.self, from: data)

        return mainModel
    }

    private func getIDNumberFromURL(from urlString: String) -> String? {
            let pattern = #"offer/(\d+)\.html"#
    
            do {
                // Create a regular expression object
                let regex = try NSRegularExpression(pattern: pattern)
    
                // Search for matches in the URL string
                let results = regex.matches(in: urlString, range: NSRange(urlString.startIndex..., in: urlString))
    
                if let match = results.first, let range = Range(match.range(at: 1), in: urlString) {
                    let number = String(urlString[range])
                    print("Extracted number: \(number)")
                    return number
                } else {
                    print("No match found")
                    return nil
                }
            } catch {
                print("Invalid regex: \(error.localizedDescription)")
                return nil
            }
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

func getImagesData(from urls: [URL]) async -> [Data] {
    var imagesData: [Data] = []
    do {
        for url in urls {
            let imageData = try await getImageData(from: url)
            imagesData.append(imageData)
        }
    } catch {
        print(error)
    }

    return imagesData
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

func getImageData(from url: URL) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid response")
        throw Errors.invalidResponse
    }

    guard httpResponse.statusCode == 200 else {
        print("HTTP error: \(httpResponse.statusCode)")
        throw Errors.httpError(code: httpResponse.statusCode)
    }

    return data
}

enum Errors: Error {
    case cantGetIDFromURL
    case imageNotFound
    case invalidResponse
    case httpError(code: Int)
    case invalidImageData
    case dataNotFound
    case photoDataNotFound
    case cantCreateImageFromData
}
