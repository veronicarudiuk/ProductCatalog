import SwiftUI

/// AsyncImage is a custom SwiftUI view that loads and displays an image from a URL asynchronously.
/// It uses ImageLoader to fetch and cache the image.

struct AsyncImage: View {
    @ObservedObject private var loader: ImageLoader
    
    private let contentMode: ContentMode
    private var width: CGFloat
    private var height: CGFloat
    private var cornerRadius: CGFloat
    private let placeholder: ImageResource
    
    init(link: String,
         contentMode: ContentMode = .fill,
         width: CGFloat = 64,
         height: CGFloat = 64,
         cornerRadius: CGFloat = 0,
         placeholder: ImageResource = .placeholder
    ) {
        _loader = ObservedObject(wrappedValue: ImageLoader(url: URL(string: link)))
        self.contentMode = contentMode
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.placeholder = placeholder
    }
    
    var body: some View {
        content
    }
}

extension AsyncImage {
    private var content: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else if loader.isLoading {
                CustomProgressView()
            } else {
                Image(placeholder)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            }
        }
        .frame(width: width, height: height)
        .cornerRadius(cornerRadius)
        .clipped()
    }
}
