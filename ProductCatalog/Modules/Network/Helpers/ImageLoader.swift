import SwiftUI

final class ImageLoader: ObservableObject {
    
    // MARK: - Properties
    
    @Published var image: UIImage?
    
    var isLoading = false
    var url: URL?
    private var cache: ImageCacheProvider
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Initialization
    
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

// MARK: - Loading & Caching

extension ImageLoader {
    
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
                        let resizedImage = self.resizeImage(image: loadedImage, targetSize: CGSize(width: 64, height: 64))
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
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

extension ImageLoader {
    
    // MARK: - Static instance
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
}
