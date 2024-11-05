import SwiftUI

/// ImageLoader handles the asynchronous loading and caching of images from a URL.

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    var isLoading = false
    var url: URL?
    private var cache: ImageCacheProvider
    private var dataTask: URLSessionDataTask?
    
    init(url: URL?,
         conteiner: DependencyContainer = .shared) {
        self.url = url
        cache = conteiner.resolve()
        load()
    }
    
    deinit {
        cancel()
    }
}

extension ImageLoader {
    // Loads the image from cache or network if not already loading
    private func load() {
        guard !isLoading, let url = url else { return }
        
        if let cachedImage = cache[url] {
            image = cachedImage
            return
        }
        
        isLoading = true
        
        ImageLoader.imageProcessingQueue.async { [weak self] in
            guard let self else { return }
            
            dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    isLoading = false
                    
                    if error != nil { return }
                    
                    if let data = data, let loadedImage = UIImage(data: data) {
                        let resizedImage = resizeImage(image: loadedImage, targetSize: CGSize(width: 64, height: 64))
                        cache[url] = resizedImage
                        image = resizedImage
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    func cancel() {
        dataTask?.cancel()
        isLoading = false
    }
    
    // Resizes the image to fit within the target size, preserving aspect ratio
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / image.size.width
        let heightRatio = targetSize.height / image.size.height
        let scaleFactor = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: image.size.width * scaleFactor,
            height: image.size.height * scaleFactor
        )
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            let xOffset = (targetSize.width - scaledImageSize.width) / 2
            let yOffset = (targetSize.height - scaledImageSize.height) / 2
            image.draw(in: CGRect(origin: CGPoint(x: xOffset, y: yOffset), size: scaledImageSize))
        }
    }
}

extension ImageLoader {
    
    // MARK: - Static instance
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
}
