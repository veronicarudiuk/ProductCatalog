import SwiftUI

/// The main home screen view that displays a list of products in a grid format.
/// Shows a loading indicator or the grid of products, depending on the state.

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: HomeViewModel())
    }
    
    var body: some View {
        main
            .setBGColor()
            .showAlert(model: $viewModel.alertModel)
            .showProductDetailView(info: $viewModel.productToShow)
    }
    
    private var main: some View {
        VStack(spacing: 0) {
            productsLabel
            
            if viewModel.products.isEmpty {
                VStack {
                    Spacer()
                    CustomProgressView()
                    Spacer()
                }
            } else {
                grids
                    .setMainHorizontalPadding()
            }
        }
        .refreshable {
            viewModel.refreshProducts()
        }
        .onDisappear {
            viewModel.cancelTasks()
        }
    }
    
    private var grids: some View {
        ScrollTrackingView(isScrolledDown: $viewModel.isScrolledDown) {
            LazyVGrid(columns: viewModel.columns, spacing: AppSizes.h4.value * 2) {
                ForEach(viewModel.products) { product in
                    ProductGridCardView(info: product,
                                        showProductDetailSubject: viewModel.showProductDetailSubject)
                    .onTapGesture {
                        viewModel.showProductDetail(product)
                    }
                    
                    .onAppear {
                        if product.id == viewModel.products.last?.id {
                            viewModel.loadProducts()
                        }
                    }
                }
            }
            
            if viewModel.isLoading {
                CustomProgressView()
            }
        }
    }
    
    private var productsLabel: some View {
        Text(main: .products)
            .foregroundStyle(.layerOne)
            .font(.aktivMedium24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, AppSizes.h24.value)
            .padding(.bottom, AppSizes.h12.value)
            .setMainHorizontalPadding()
            .setBGColor()
            .doubleShadow(viewModel.isScrolledDown ? .shadowTwo : .clear)
    }
}
