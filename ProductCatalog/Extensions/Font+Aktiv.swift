import SwiftUI

enum Aktiv: String {
    case bold = "AktivGroteskCorp-Bold"
    case medium = "AktivGroteskCorp-Medium"
    case light = "AktivGroteskCorp-Light"
    
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
    static let aktivBold32 = aktivDisplay(.bold,
                                          size: 32)
    static let aktivBold18 = aktivDisplay(.bold,
                                          size: 18)
    static let aktivBold14 = aktivDisplay(.bold,
                                          size: 14)
    static let aktivBold10 = aktivDisplay(.bold,
                                          size: 10)
    
    static let aktivMedium24 = aktivDisplay(.medium,
                                            size: 24)
    static let aktivMedium18 = aktivDisplay(.medium,
                                            size: 18)
    static let aktivMedium16 = aktivDisplay(.medium,
                                            size: 16)
    static let aktivMedium14 = aktivDisplay(.medium,
                                            size: 14)
    
    static let aktivLight18 = aktivDisplay(.light,
                                           size: 18)
    static let aktivLight14 = aktivDisplay(.light,
                                           size: 14)
}
