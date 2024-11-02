import SwiftUI

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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
