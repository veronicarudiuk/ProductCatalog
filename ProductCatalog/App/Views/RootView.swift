import SwiftUI

/// RootView is the main entry point of the app's UI.
/// It uses a navigation stack to switch between different views based on the current state managed by RootViewModel.

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack {
            switch viewModel.currentView {
            case .preloader:
                AppRouter.preloader.view
                    .onAppear(perform: viewModel.loadInitialData)
            case .main:
                AppRouter.main.view
            }
        }
    }
}
