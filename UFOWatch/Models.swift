import Foundation

struct UFORelease: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let titleJa: String
    let date: String
    let items: [UFOItem]
}

struct UFOItem: Identifiable, Codable, Hashable {
    let id: String
    let imageURL: String
    let description: String
    let descriptionJa: String
    let location: String
    let locationJa: String
    let date: String
    let source: String
    let latitude: Double?
    let longitude: Double?
    let category: UFOCategory
}

enum UFOCategory: String, Codable, CaseIterable, Hashable {
    case fbiInfrared = "FBI赤外線"
    case fbiSketch = "FBI合成"
    case nasa = "NASA"
    case military = "軍事記録"

    var color: String {
        switch self {
        case .fbiInfrared: return "infrared"
        case .fbiSketch: return "sketch"
        case .nasa: return "nasa"
        case .military: return "military"
        }
    }
}
