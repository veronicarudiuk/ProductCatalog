import SwiftUI

final class DependencyContainer {
    
    // MARK: - Static instance
    public static let shared = DependencyContainer()
    
    // MARK: - Instance properties
    private var services: [String: Any] = [:]
    private let queue = DispatchQueue(label: "com.dependency.container", attributes: .concurrent)
    
    // MARK: - Container logic
    func register<T>(interface: T.Type, service: T) {
        let key = String(describing: interface)
        queue.sync(flags: .barrier) {
            services[key] = service
        }
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        return queue.sync {
            services[key] as! T
        }
    }
}

extension DependencyContainer {
    
    //MARK: - static func
    public static func registerClients() {
        shared.register(interface: ImageCacheProvider.self,
                        service: ImageCache())
        
        shared.register(interface: DummyjsonAPIProvider.self,
                        service: DummyjsonAPI())
    }
}

//MARK: - Dependencies Protocols
protocol ImageCacheDependencies {
    var imageCache: ImageCacheProvider { get }
}

protocol DummyjsonAPIDependencies {
    var dummyjsonAPI: DummyjsonAPIProvider { get }
}

protocol DependencyContainerProtocol: ImageCacheDependencies, DummyjsonAPIDependencies {}

extension DependencyContainer: DependencyContainerProtocol {
    // MARK: - WeatherServiceDependencies
    var imageCache: ImageCacheProvider {
        get  { resolve() }
    }
    
    // MARK: - DetailServiceDependencies
    var dummyjsonAPI: DummyjsonAPIProvider {
        get  { resolve() }
    }
}
