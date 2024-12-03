import XCTest
import Combine
@testable import ProductCatalog

extension DependencyContainer {
    static func mock(dummyAPI: DummyjsonAPIProvider) -> DependencyContainer {
        let container = DependencyContainer()
        container.register(interface: DummyjsonAPIProvider.self, service: dummyAPI)
        return container
    }
}

final class MockDummyjsonAPIProvider: DummyjsonAPIProvider {
    var getProductsResult: Result<[Product], Error>?
    
    func getProducts(skip: String, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        if let result = getProductsResult {
            completion(result)
        } else {
            completion(.failure(NetworkError.requestFailed))
        }
    }
}

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel?
    private var dummyAPI: MockDummyjsonAPIProvider?
    private var cancellables: Set<AnyCancellable>?
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        dummyAPI = MockDummyjsonAPIProvider()
        
        if let dummyAPI = dummyAPI {
            viewModel = HomeViewModel(conteiner: .mock(dummyAPI: dummyAPI))
        }
    }
    
    override func tearDown() {
        viewModel = nil
        dummyAPI = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadProductsSuccess() {
        guard let viewModel, let dummyAPI, var cancellables else {
            XCTFail("Dependencies not initialized")
            return
        }
        
        let mockProducts = [
            Product(id: 1, title: "Test Product", description: "Test Description", price: 10.0, stock: 100, images: ["image1.jpg"]),
            Product(id: 2, title: "Another Product", description: "Another Description", price: 20.0, stock: 50, images: ["image2.jpg"])
        ]
        
        dummyAPI.getProductsResult = .success(mockProducts)
        
        let expectation = XCTestExpectation(description: "Products loaded successfully")
        
        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products.count, mockProducts.count)
                XCTAssertEqual(products.first?.title, mockProducts.first?.title)
                XCTAssertEqual(products.last?.price, mockProducts.last?.price)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadProducts()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testLoadProductsFailure() {
        guard let viewModel, let dummyAPI, var cancellables else {
            XCTFail("Dependencies not initialized")
            return
        }
        
        let mockError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        dummyAPI.getProductsResult = .failure(mockError)
        
        let expectation = XCTestExpectation(description: "Error handled correctly")
        
        viewModel.$alertModel
            .dropFirst()
            .sink { alertModel in
                XCTAssertNotNil(alertModel)
                XCTAssertEqual(alertModel?.message, mockError.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadProducts()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefreshProducts() {
        guard let viewModel, let dummyAPI, var cancellables else {
            XCTFail("Dependencies not initialized")
            return
        }
        
        viewModel.products = [Product(id: 1, title: "Old Product", description: "Old Description", price: 5.0, stock: 30, images: ["oldimage.jpg"])]
        
        let refreshedProducts = [
            Product(id: 2, title: "New Product", description: "New Description", price: 15.0, stock: 20, images: ["newimage.jpg"])
        ]
        
        dummyAPI.getProductsResult = .success(refreshedProducts)
        
        let expectation = XCTestExpectation(description: "Products refreshed successfully")
        
        var updateCount = 0
        
        viewModel.$products
            .dropFirst(2)
            .sink { products in
                XCTAssertEqual(products.count, refreshedProducts.count, "The count of products after refresh is not as expected")
                XCTAssertEqual(products.first?.title, refreshedProducts.first?.title, "The title of the first product after refresh is not as expected")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        
        viewModel.refreshProducts()
        debugOutput("")
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testShowProductDetail() {
        guard let viewModel, var cancellables else {
            XCTFail()
            return
        }
        
        let testProduct = Product(id: 3, title: "Detail Product", description: "Detail Description", price: 20.0, stock: 40, images: ["detailimage.jpg"])
        
        let expectation = XCTestExpectation(description: "Product detail shown")
        
        viewModel.$productToShow
            .dropFirst() 
            .sink { product in
                XCTAssertEqual(product?.id, testProduct.id)
                XCTAssertEqual(product?.title, testProduct.title)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.showProductDetail(testProduct)
        
        wait(for: [expectation], timeout: 2.0)
    }
}
