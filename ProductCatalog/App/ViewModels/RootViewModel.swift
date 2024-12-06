import SwiftUI

/// RootViewModel is responsible for managing the current view state of the app.
/// It initially shows a preloader view, then transitions to the main view after loading initial data.

final class RootViewModel: ObservableObject {
    @Published private(set) var currentView: Page
    
    init() {
        DependencyContainer.registerClients()
        currentView = .preloader
    }
    
    func loadInitialData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            currentView = .main
        }
    }
}
