import SwiftUI

/// ImageLoader handles the asynchronous loading and caching of images from a URL using Swift Concurrency.

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = true
    private let url: URL?
    private var cache: ImageCacheProvider
    
    init(url: URL?, container: DependencyContainer = .shared) {
        self.url = url
        self.cache = container.resolve()
    }
}

extension ImageLoader {
    func fetchImage() async {
        guard let url = url else { return }
        
        if let cachedImage = cache[url] {
            isLoading = false
            image = cachedImage
            return
        }
        
        let newImage = try? await downloadWithAsync(url)
        isLoading = false
        self.image = newImage
    }
    
    func downloadWithAsync(_ url: URL) async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(url: url, data: data, response: response)
        } catch {
            throw error
        }
    }
    
    func handleResponse(url: URL, data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        let resizedImage = image.resized(to: CGSize(width: 64, height: 64))
        cache[url] = resizedImage
        return resizedImage
    }
}
