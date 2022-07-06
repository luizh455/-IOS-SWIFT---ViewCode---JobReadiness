import Foundation



// MARK: - TopCategory
struct TopCategory: Codable {
    let queryData: QueryData
    let content: [Content]

    enum CodingKeys: String, CodingKey {
        case queryData = "query_data"
        case content
    }
}

// MARK: - Content
struct Content: Codable {
    let id: String
    let position: Int
    let type: String
}



// MARK: - QueryData
struct QueryData: Codable {
    let highlightType, criteria, id: String

    enum CodingKeys: String, CodingKey {
        case highlightType = "highlight_type"
        case criteria, id
    }
}
