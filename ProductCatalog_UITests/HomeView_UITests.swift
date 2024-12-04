import XCTest

final class HomeViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testHomeViewElementsExist() throws {
        let productsLabel = app.staticTexts["Products"]
        XCTAssertTrue(productsLabel.waitForExistence(timeout: 5), "Products label is missing")
    }
}
