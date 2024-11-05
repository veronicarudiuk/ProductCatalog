import SwiftUI

/// SharedImageCache is a image cache provider that uses NSCache to store images in memory, providing fast access to previously loaded images.

protocol ImageCacheProvider {
    subscript(_ url: URL) -> UIImage? { get set }
}

final class SharedImageCache: ImageCacheProvider {

    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100 
        cache.totalCostLimit = 1024 * 1024 * 100
        
        return cache
    }()
    
    // Caching subscript - fetches or stores images
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set {
            if let image = newValue {
                cache.setObject(image, forKey: key as NSURL)
            } else {
                cache.removeObject(forKey: key as NSURL)
            }
        }
    }
}
