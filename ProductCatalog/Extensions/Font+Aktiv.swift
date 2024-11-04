import SwiftUI

enum Aktiv: String {
    case bold = "AktivGroteskCorp-Bold"
    case medium = "AktivGroteskCorp-Medium"
    
    var name : String {
        rawValue
    }
}

extension Font {
    
    //MARK: - stutic func
    private static func aktivDisplay(_ font: Aktiv,
                                     size: CGFloat = 8) -> Font {
        .custom(font.name, size: size)
    }
    
    //MARK: - stutic instance
    static let aktivBold18 = aktivDisplay(.bold,
                                          size: 18)
    
    static let aktivMedium24 = aktivDisplay(.medium,
                                            size: 24)
    static let aktivMedium14 = aktivDisplay(.medium,
                                            size: 14)
    static let aktivMedium12 = aktivDisplay(.medium,
                                            size: 12)
}
