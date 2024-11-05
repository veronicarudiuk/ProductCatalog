import Foundation

/// NetworkError is an enum for categorizing network errors, with custom descriptions for localization.

enum NetworkError: Error, LocalizedError {
    case noInternetConnection
    case linkError
    case noData
    case requestFailed
    case transportError(Error)
    case serverError
    case validationError(String)

    var errorDescription: String? {
        switch self {
        case .noData:
            return AppText.NetworkErrorMessages.invalidData.rawValue
        case .requestFailed:
            return AppText.NetworkErrorMessages.requestFailed.rawValue
        case .serverError:
            return AppText.NetworkErrorMessages.responseUnsuccessful.rawValue
        case .linkError:
            return AppText.NetworkErrorMessages.invalidLink.rawValue
        case .transportError(let error):
            return "\(AppText.NetworkErrorMessages.transportError.rawValue)\(error.localizedDescription)"
        case .validationError(let reason):
            return "\(AppText.NetworkErrorMessages.validationError.rawValue)\(reason)"
        case .noInternetConnection:
            return AppText.NetworkErrorMessages.theInternetConnection.rawValue
        }
    }
}

