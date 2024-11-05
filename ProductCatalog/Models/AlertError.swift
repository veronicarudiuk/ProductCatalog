import SwiftUI

struct AlertError: Identifiable {
    let message: String
    let alertButton: Alert.Button
    
    var id: String {
        UUID().uuidString
    }
    
    init(message: String,
         alertButton: Alert.Button = .default(Text(alert: .ok), action: {})) {
        self.message = message
        self.alertButton = alertButton
    }
}
