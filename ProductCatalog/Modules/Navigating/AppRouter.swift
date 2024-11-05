import SwiftUI

/// AppRouter handles view routing within the app, allowing a switch between different main screens.

enum AppRouter {
    case preloader
    case main
    
    var view: some View {
        Group {
            switch self {
            case .preloader:
                PreloaderView()
            case .main:
                HomeView()
            }
        }
    }
}
