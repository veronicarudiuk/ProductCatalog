import SwiftUI

struct DoubleShadow {
    var color1: Color
    var radius1: CGFloat
    var x1: CGFloat
    var y1: CGFloat
    
    var color2: Color
    var radius2: CGFloat
    var x2: CGFloat
    var y2: CGFloat
}

enum AppShadows {
    case shadowOne
    case shadowTwo
    case clear
    
    var doubleShadow: DoubleShadow {
        switch self {
        case .shadowOne:
            return DoubleShadow(color1: .black.opacity(0.32), radius1: 4, x1: 0, y1: 1,
                                color2: .black.opacity(0.32), radius2: 16, x2: 0, y2: 4)

        case .shadowTwo:
            return DoubleShadow(color1: .black.opacity(0.08), radius1: 4, x1: 0, y1: -1,
                                color2: .black.opacity(0.08), radius2: 16, x2: 0, y2: -4)
            
        case .clear:
            return DoubleShadow(color1: .clear, radius1: 0, x1: 0, y1: 0,
                                color2: .clear, radius2: 0, x2: 0, y2: 0)
        }
    }
}
