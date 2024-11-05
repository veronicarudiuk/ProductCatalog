import SwiftUI

/// DependencyContainer is a simple dependency injection container that allows registering and resolving services within the app.

final class DependencyContainer {
    
    //MARK: - static instance
    public static var shared = DependencyContainer()
    
    //MARK: - instance
    private var services: [String: Any] = [:]
    
    //MARK: - container logic
    func register<T>(interface: T.Type,
                     service: T) {
        let key = String(describing: interface)
        services[key] = service
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        return services[key] as! T
    }
}

extension DependencyContainer {
    
    //MARK: - static func
    func registerClients() {
        
        register(interface: ImageCacheProvider.self,
                 service: SharedImageCache())
        
        register(interface: DummyjsonAPIProvider.self,
                 service: DummyjsonAPI())
    }
}
