import SwiftUI

enum AppSizes {
    case
    screenWidth,
    screenHeight,
    
    w16
    
    var value: CGFloat {
        switch self {
        case .screenWidth:
            return screenWidth
        case .screenHeight:
            return screenHeight
            
        case .w16:
            return screenWidth * 0.04
            
        }
    }
    
    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}
