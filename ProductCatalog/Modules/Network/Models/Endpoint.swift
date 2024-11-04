import Foundation

/// Represents an API endpoint with path and query parameters.

struct Endpoint {
    
    //MARK: - instance
    let path: String
    let queryItems: [URLQueryItem]
}

//MARK: - URL
extension Endpoint {
    
    var dummyjsonAPI: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dummyjson.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

extension Endpoint {
    
    //MARK: - nested enums
    enum Path {
        case products
        
        var rawValue: String {
            switch self {
            case .products:
                return "/products"
            }
        }
    }
    
    enum Query {
        case limit(String)
        case skip(String)

        var name: String {
            switch self {
            case .limit:
                return "limit"
            case .skip:
                return "skip"
            }
        }
        
        var value: String {
            switch self {
            case .limit(let limit):
                return limit
            case .skip(let skip):
                return skip
            }
        }
    }
}

