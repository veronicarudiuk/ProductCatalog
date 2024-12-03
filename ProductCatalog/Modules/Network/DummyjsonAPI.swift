import Foundation

/// Implements DummyjsonAPIProvider to handle product requests through APIClient.

protocol DummyjsonAPIProvider {
    func getProducts(skip: String, limit: Int) async throws -> [Product]
}

final class DummyjsonAPI: APIClient, DummyjsonAPIProvider {

    // MARK: - Instance
    let session: URLSession
    private var currentTask: URLSessionDataTask?

    // MARK: - Initialization
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral) {
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        configuration.networkServiceType = .responsiveData
        configuration.requestCachePolicy = .useProtocolCachePolicy
        session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func getProducts(skip: String, limit: Int) async throws -> [Product] {
        let endpoint = makeEndPoint(with: .products, and: [.limit(String(limit)), .skip(skip)])
        let request = try makeURLRequest(with: .dummyjson(endpoint: endpoint), and: .GET)
        
        let response: Response<ProductResponse> = try await execute(request)
        return response.value.products
    }
}
