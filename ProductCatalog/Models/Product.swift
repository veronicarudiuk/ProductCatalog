import Foundation

struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let stock: Int
    let images: [String]
}
