import SwiftUI

/// AppRouter handles view routing within the app, allowing a switch between different main screens.

enum Page: Hashable, Equatable {
    case preloader
    case main
}
