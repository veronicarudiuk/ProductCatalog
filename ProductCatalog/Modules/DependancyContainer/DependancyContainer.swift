import SwiftUI

final class DependencyContainer: ObservableObject {
    @Published var imageCacheService: ImageCacheProvider
    @Published var dummyjsonAPIService: DummyjsonAPIProvider

    init() {
        self.imageCacheService = ImageCache()
        self.dummyjsonAPIService = DummyjsonAPI()
    }
}
