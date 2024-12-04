import SwiftUI
import Combine

/// ViewModel for the HomeView. Manages product data and handles pagination and loading states.
/// Provides a subject for showing product details.

@MainActor
final class HomeViewModel: ObservableObject {
    private let dummyjsonAPI: DummyjsonAPIProvider
    let imageCache: ImageCacheProvider
    
    @Published var isScrolledDown: Bool = false
    
    @Published var alertModel: AlertError?
    @Published var productToShow: Product?
    
    @Published var isLoading = false
    @Published var products: [Product] = []
    
    private var currentPage = 0
    private let limit = 20
    
    // Subject for showing product details
    let showProductDetailSubject = PassthroughSubject<Product, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // Defines columns for grid layout
    private(set) var columns = [
        GridItem(.flexible(), spacing: AppSizes.w8.value),
        GridItem(.flexible(), spacing: AppSizes.w8.value),
        GridItem(.flexible(), spacing: AppSizes.w8.value)
    ]
    
    private var tasks: [Task<Void, Never>] = []
    
    init(dummyjsonAPI: DummyjsonAPIProvider, imageCache: ImageCacheProvider) {
        self.dummyjsonAPI = dummyjsonAPI
        self.imageCache = imageCache
        setupSubscriptions()
        loadProducts()
    }
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
    
    // Loads products with current pagination settings
    func loadProducts() {
        guard !isLoading else { return }
        isLoading = true
        let skip = String(currentPage * limit)
        cancelTasks()
        
        
        let task = Task {
            do {
                let newProducts = try await dummyjsonAPI.getProducts(skip: skip, limit: limit)
                products.append(contentsOf: newProducts)
                currentPage += 1
                isLoading = false
            } catch {
                alertModel = AlertError(message: error.localizedDescription,
                                        alertButton: .default(Text(alert: .retry), action: loadProducts))
                debugOutput(error)
                isLoading = false
            }
        }
        tasks.append(task)
    }
    
    func refreshProducts() {
        currentPage = 0
        products.removeAll()
        loadProducts()
    }
}

extension HomeViewModel {
    private func setupSubscriptions() {
        showProductDetailSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] item in
                guard let self else { return }
                showProductDetail(item)
            }
            .store(in: &cancellables)
    }
    
    func showProductDetail(_ item: Product) {
        productToShow = item
    }
}
