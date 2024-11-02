import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: HomeViewModel())
    }
    
    var body: some View {
        main
            .setBGColor()
            .setMainHorizontalPadding()
    }
    
    private var main: some View {
        VStack(spacing: 0) {
            header
            grids
        }
    }
    
    private var header: some View {
        EmptyView() //!!
    }
    
    private var grids: some View {
        EmptyView()
        //!
    }
}
