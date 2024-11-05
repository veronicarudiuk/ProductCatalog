extension AppText {
    enum Alert: String {
        case anErrorOccurred = "An error occurred while retrieving data: "
        case anErrorHasOccurre = "An error has occurred. The connection to the server has been lost. This may be due to a bad Internet connection or a server error."
        case retry = "Retry"
        case ok = "OK"
        case error = "Error"
    }
}
