import SwiftUI

final class RootViewModel: ObservableObject {
    enum CurrentViewType {
        case preloader
        case main
    }
    
    @Published private(set) var currentView: CurrentViewType
    
    init(conteiner: DependencyContainer = .shared) {
        DependencyContainer.registerClients()
        currentView = .preloader
    }
    
    func loadInitialData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self else { return }
            currentView = .main
        }
    }
}
