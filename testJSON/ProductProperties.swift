
import Foundation

struct ProductProperties {
    var fabricName: String?
    var mainFabricComposition: String?
    var article: String?
    var colour: String?
    var size: String?
    var mainFabricContent: String?


    init(prop: [[String : String]]) {
        var singleDictionary: [String: String] = [:]

        for dictionary in prop {
            for (key, value) in dictionary {
                if singleDictionary[key] == nil {
                    singleDictionary[key] = value
                }
            }
        }

        self.fabricName = singleDictionary[Props.fabricName.rawValue]
        self.mainFabricComposition = singleDictionary[Props.mainFabricComposition.rawValue]
        self.article = singleDictionary[Props.articleNumber.rawValue]
        self.colour = singleDictionary[Props.colour.rawValue]
        self.size = singleDictionary[Props.size.rawValue]
        self.mainFabricContent = singleDictionary[Props.mainFabricContent.rawValue]
    }

    enum Props: String {
        case fabricName = "面料名称"
        case mainFabricComposition = "主面料成分"
        case articleNumber = "货号"
        case colour = "颜色"
        case size = "尺码"
        case mainFabricContent = "主面料成分含量"
    }
}
