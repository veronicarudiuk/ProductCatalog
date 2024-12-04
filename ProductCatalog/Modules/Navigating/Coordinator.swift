import SwiftUI

final class Coordinator: ObservableObject {
    
    let container = DependencyContainer()
    
    @Published var path = NavigationPath()
    
    func push(page: Page) {
        path.append(page)
    }
    
    @ViewBuilder
    func build (page: Page) -> some View {
        switch page {
        case .preloader:
            PreloaderView()
        case .main:
            HomeView(dummyjsonAPI: container.dummyjsonAPIService, imageCache: container.imageCacheService)
        }
    }
}
