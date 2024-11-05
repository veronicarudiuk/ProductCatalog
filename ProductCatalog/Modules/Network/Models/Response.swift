import Foundation

/// Represents a generic response object holding decoded value and the raw URL response.

struct Response<T> {
    
    //MARK: - instance
    let value: T
    let response: URLResponse
}
