import SwiftUI

/// RootView is the main entry point of the app's UI.
/// It uses a navigation stack to switch between different views based on the current state managed by RootViewModel.

struct RootView: View {
    @StateObject private var coordinator = Coordinator()
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: viewModel.currentView)
                .navigationDestination (for: Page.self) { page in
                    coordinator.build (page: page)
                }
        }
        .environmentObject(coordinator)
        .onAppear(perform: viewModel.loadInitialData)
    }
}
