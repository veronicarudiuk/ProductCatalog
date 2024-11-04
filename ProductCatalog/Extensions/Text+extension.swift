import SwiftUI

extension Text {
    init(main: AppText.Main) {
        self.init(main.rawValue)
    }
    
    init(alert: AppText.Alert) {
        self.init(alert.rawValue)
    }
}
