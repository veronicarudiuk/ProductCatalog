import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    let showProductDetailSubject = PassthroughSubject<Product, Never>()
}

