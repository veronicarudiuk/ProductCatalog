import SwiftUI

/// RootViewModel is responsible for managing the current view state of the app.
/// It initially shows a preloader view, then transitions to the main view after loading initial data.

final class RootViewModel: ObservableObject {
    enum CurrentViewType {
        case preloader
        case main
    }
    
    @Published private(set) var currentView: CurrentViewType
    
    init(conteiner: DependencyContainer = .shared) {
        conteiner.registerClients()
        currentView = .preloader
    }
    
    func loadInitialData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            currentView = .main
        }
    }
}
