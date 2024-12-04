import SwiftUI
import Combine

/// Displays detailed information about a product, including images, price, and stock.
/// Allows users to dismiss the view by tapping a cancel button or the background area.

struct ProductDetailView: View {
    @Binding var info: Product?
    let imageCache: ImageCacheProvider
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            main
                .onTapGesture { }
        }
        .background(Color.layerOne.opacity(0.2))
        .onTapGesture {
            info = nil
        }
    }
    
    private var main: some View {
        VStack(spacing: AppSizes.h4.value) {
            top
                .zIndex(1)
            images
                .zIndex(0)
            price
            
            stock
            
            description
            
        }
        .background(.backgroundOne)
    }
    
    private var top: some View {
        HStack(spacing: 0) {
            name
            Spacer()
            cancelButton
        }
        .padding(.vertical, AppSizes.h12.value)
        .setMainHorizontalPadding()
    }
}


extension ProductDetailView {
    @ViewBuilder
    private var price: some View {
        if let info {
            HStack(spacing: 2) {
                Text(String(info.price))
                    .foregroundStyle(.layerOne)
                    .font(.aktivMedium24)
                
                Text(main: .dollar)
                    .foregroundStyle(.layerOne)
                    .font(.aktivMedium24)
                
                Spacer()
            }
            .setMainHorizontalPadding()
        } else {
            EmptyView()
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            info = nil
        }) {
            Image(.iconClose)
                .resizable()
                .frame(width: AppSizes.h24.value,
                       height: AppSizes.h24.value)
                .padding(AppSizes.h12.value)
                .foregroundStyle(.layerOne)
        }
    }
}

extension ProductDetailView {
    @ViewBuilder
    private var images: some View {
        if let info, !info.images.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(info.images, id: \.self) { imageUrl in
                        AsyncImage(link: imageUrl,
                                   width: AppSizes.screenWidth.value / 3,
                                   height: AppSizes.screenWidth.value / 3,
                                   imageCache: imageCache)
                            .clipped()
                    }
                    .setMainHorizontalPadding()
                }
            }
            .frame(height: AppSizes.screenWidth.value / 3)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var name: some View {
        if let info {
            Text(info.title.uppercased())
                .foregroundStyle(.layerOne)
                .font(.aktivBold18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .padding(.top, AppSizes.h4.value)
                .padding(.bottom, AppSizes.h12.value)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var stock: some View {
        if let info {
            HStack(spacing: 0) {
                Text(String(info.stock))
                    .foregroundStyle(.layerOne)
                    .font(.aktivMedium14)
                Text(main: .stock)
                    .foregroundStyle(.layerOne)
                    .font(.aktivMedium14)
                Spacer()
            }
            .setMainHorizontalPadding()
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var description: some View {
        if let info {
            Text(String(info.description))
                .foregroundStyle(.layerOne)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.aktivMedium14)
                .setMainHorizontalPadding()
                .padding(.top, AppSizes.h12.value)
                .padding(.bottom, AppSizes.h24.value)
        } else {
            EmptyView()
        }
    }
}


