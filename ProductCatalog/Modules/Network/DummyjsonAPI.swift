import Foundation

/// Implements DummyjsonAPIProvider to handle product requests through APIClient.

protocol DummyjsonAPIProvider {
    func getProducts(skip: String, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void)
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

    func getProducts(skip: String, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let endpoint = makeEndPoint(with: .products, and: [.limit(String(limit)), .skip(skip)])
        
        guard let request = try? makeURLRequest(with: .dummyjson(endpoint: endpoint), and: .GET) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.requestFailed))
            }
            return
        }

        currentTask?.cancel()
        
        execute(request) { (result: Result<Response<ProductResponse>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response.value.products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
