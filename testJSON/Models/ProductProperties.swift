
import Foundation

struct ProductProperties {
    var mainFabricComposition: String?
    var article: String?
    var colour: String?
    var sizesChinese: [String]?
    var fabricPercent: String?
    var fabricValueForTable: String?
    var fabricValueChinise: String?


    init(prop: [[String : String]]) {
        var singleDictionary: [String: String] = [:]

        for dictionary in prop {
            for (key, value) in dictionary {
                if singleDictionary[key] == nil {
                    singleDictionary[key] = value
                }
            }
        }

        self.mainFabricComposition = singleDictionary[Props.mainFabricComposition.rawValue]
        self.article = singleDictionary[Props.articleNumber.rawValue]?.removeChineseCharacters()
        self.colour = singleDictionary[Props.colour.rawValue]
        self.sizesChinese = singleDictionary[Props.size.rawValue]?.components(separatedBy: ",")
        self.fabricPercent = singleDictionary[Props.fabricPercent.rawValue]

        let numberSring = extractNumber(from: fabricPercent) ?? ""
        self.fabricValueForTable = numberSring + (mainFabricComposition ?? "No fabric")
        self.fabricValueChinise = numberSring + (mainFabricComposition ?? "No fabric")
    }

    func extractNumber(from string: String?) -> String? {
        // Define the regular expression pattern for numbers 1 to 100
        guard let string else {
            print("NO number in fabrict string")
            return nil
        }
        let pattern = "\\b([1-9][0-9]?|100)\\b"

        // Create the regular expression object
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            print("Invalid regular expression pattern.")
            return nil
        }

        // Search for the first match in the string
        let range = NSRange(location: 0, length: string.utf16.count)
        if let match = regex.firstMatch(in: string, options: [], range: range) {
            if let range = Range(match.range, in: string) {
                let numberString = String(string[range])
                return numberString
            }
        }

        return nil
    }

    enum Props: String {
        case mainFabricComposition = "主面料成分"
        case articleNumber = "货号"
        case colour = "颜色"
        case size = "尺码"
        case fabricPercent = "主面料成分的含量"
    }
}


extension String {
    func removeChineseCharacters() -> String {
        let pattern = "[^a-zA-Z0-9\\s-]" // pattern to match non-alphanumeric characters, excluding hyphens and spaces
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.utf16.count)
        let modifiedString = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        return modifiedString
    }
}
