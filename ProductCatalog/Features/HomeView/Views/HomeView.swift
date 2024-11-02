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
            
            productsLabel
            
            grids
        }
    }
    
    private var header: some View {
        EmptyView() //!!
    }
    
    private var grids: some View {
        ProductGridView(clothing: products,
                         showProductDetailSubject: viewModel.showProductDetailSubject)
    }
    
    private var productsLabel: some View {
        Text(main: .products)
            .foregroundStyle(.layerOne)
            .font(.aktivMedium24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, AppSizes.h24.value)
            .padding(.bottom, AppSizes.h12.value)
    }
}
