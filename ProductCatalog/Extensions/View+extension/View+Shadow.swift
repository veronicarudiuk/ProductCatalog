import SwiftUI

extension View {
    func doubleShadow(_ shadow: AppShadows) -> some View {
        self.modifier(DoubleShadowModifier(shadow: shadow.doubleShadow))
    }
}

struct DoubleShadowModifier: ViewModifier {
    let shadow: DoubleShadow
    
    func body(content: Content) -> some View {
        content
            .shadow(color: shadow.color1, radius: shadow.radius1, x: shadow.x1, y: shadow.y1)
            .shadow(color: shadow.color2, radius: shadow.radius2, x: shadow.x2, y: shadow.y2)
    }
}
