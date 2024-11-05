import SwiftUI
import Combine

// Extension on View to add a modifier that shows the product detail view when a product is selected.

extension View {
    func showProductDetailView(info: Binding<Product?>) -> some View {
        self.modifier(ProductDetailViewModifier(info: info))
    }
}

struct ProductDetailViewModifier: ViewModifier {
    @Binding private var info: Product?
    
    init(info: Binding<Product?>) {
        _info = info
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if info != nil {
                ProductDetailView(info: $info)

                .zIndex(1)
                .id(info?.id)
            }
        }
        .onAppear {
            info = nil
        }
    }
}

