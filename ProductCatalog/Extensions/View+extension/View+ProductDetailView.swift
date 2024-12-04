import SwiftUI
import Combine

// Extension on View to add a modifier that shows the product detail view when a product is selected.

extension View {
    func showProductDetailView(info: Binding<Product?>, imageCache: ImageCacheProvider) -> some View {
        self.modifier(ProductDetailViewModifier(info: info, imageCache: imageCache))
    }
}

struct ProductDetailViewModifier: ViewModifier {
    @Binding private var info: Product?
    let imageCache: ImageCacheProvider
    
    init(info: Binding<Product?>, imageCache: ImageCacheProvider) {
        _info = info
        self.imageCache = imageCache
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if info != nil {
                ProductDetailView(info: $info, imageCache: imageCache)

                .zIndex(1)
                .id(info?.id)
            }
        }
        .onAppear {
            info = nil
        }
    }
}

