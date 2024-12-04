import Foundation

/// Protocol defining a generic API client for executing network requests.

protocol APIClient {
    var session: URLSession { get }
    func execute<T: Decodable>(_ request: URLRequest) async throws -> Response<T>
}

extension APIClient {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> Response<T> {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                throw statusCode >= 400 && statusCode < 500 ? NetworkError.validationError(String(statusCode)) : NetworkError.serverError
            }
            
            let decodedData: T = try decodeData(T.self, from: data)
            return Response(value: decodedData, response: httpResponse)
        } catch {
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                throw NetworkError.noInternetConnection
            }
            throw NetworkError.transportError(error)
        }
    }
    
    func decodeData<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

extension APIClient {
    // Creates an endpoint with path and query parameters
    func makeEndPoint(with path: Endpoint.Path,
                      and queries: [Endpoint.Query]) -> Endpoint {
        var queryItems : [URLQueryItem] = []
        
        queries.forEach {
            let queryItem : URLQueryItem = .init(name: $0.name,
                                                 value: $0.value)
            queryItems.append(queryItem)
        }
        
        return Endpoint(path: path.rawValue,
                        queryItems: queryItems)
    }
    
    // Creates a URLRequest with specified API type and HTTP method
    func makeURLRequest(with apiType: APIType,
                        and httpMethod: HTTPMethod) throws -> URLRequest {
        guard let url = apiType.url else { throw NetworkError.linkError }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.networkServiceType = .responsiveData
        
        return request
    }
}

enum HTTPMethod: String {
    case GET
    
    var rawValue: String {
        switch self {
        case .GET:
            return "GET"
        }
    }
}

enum APIType {
    case dummyjson (endpoint: Endpoint)

    var url : URL? {
        switch self {
        case .dummyjson(let endpoint):
            return endpoint.dummyjsonAPI
        }
    }
}
