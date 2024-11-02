import SwiftUI

enum AppRouter {
    case preloader
    case main
//    case favorites
    
    var view: some View {
        Group {
            switch self {
            case .preloader:
                PreloaderView()
            case .main:
                HomeView()
//            case .favorites:
//                FavoritesView()
            }
        }
    }
}
