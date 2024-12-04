import SwiftUI
import Combine

/// Represents a single product card within the grid.
/// Displays the product image, price, stock, and name.

struct ProductGridCardView: View {
    private(set) var info: Product
    let showProductDetailSubject: PassthroughSubject<Product, Never>
    let imageCache: ImageCacheProvider
    
    var body: some View {
        main
            .contentShape(Rectangle())
            .onTapGesture {
            showProductDetailSubject.send(info)
            }
    }
    
    private var main: some View {
        VStack(spacing: AppSizes.h4.value) {
            card
            name
        }
        .padding(.bottom, 6)
    }
    
    private var card: some View {
        ZStack {
            image
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    stock
                }
                
                Spacer()
                
                HStack {
                    price
                    Spacer()
                }
            }
            .padding(AppSizes.w8.value)
        }
        .frame(height: AppSizes.gridCardHeight.value)
        .background(.layerFive)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var image: some View {
        AsyncImage(
            link: info.images.first ?? "",
            width: 64,
            height: 64,
            imageCache: imageCache)
    }
    
    private var price: some View {
        HStack(spacing: 2) {
            Text(String(info.price))
                .foregroundStyle(.layerTwo)
                .font(.aktivMedium14)
            
            Text(main: .dollar)
                .foregroundStyle(.layerTwo)
                .font(.aktivMedium14)
        }
    }
    
    private var stock: some View {
        HStack(spacing: 0) {
            Text(String(info.stock))
                .foregroundStyle(.layerTwo)
                .font(.aktivMedium12)
            Text(main: .stock)
                .foregroundStyle(.layerTwo)
                .font(.aktivMedium12)
        }
    }
    
    private var name: some View {
        ZStack(alignment: .top) {
            Text(String(repeating: "А", count: 100))
                .foregroundStyle(.clear)
                .lineLimit(2)
                .font(.aktivMedium12)
            Text(info.title)
                .foregroundStyle(.layerOne)
                .font(.aktivMedium12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(alignment: .top)
                .setBGColor()
        }
    }
}


