import UIKit

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / self.size.width
        let heightRatio = targetSize.height / self.size.height
        let scaleFactor = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: self.size.width * scaleFactor,
            height: self.size.height * scaleFactor
        )
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            let xOffset = (targetSize.width - scaledImageSize.width) / 2
            let yOffset = (targetSize.height - scaledImageSize.height) / 2
            self.draw(in: CGRect(origin: CGPoint(x: xOffset, y: yOffset), size: scaledImageSize))
        }
    }
}
