import SwiftUI

/// A button that, when tapped, scrolls to the top of the page.
/// Displays an arrow icon to indicate the scroll-to-top action.

struct ArrowUpButton: View {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        VStack {
            Spacer()
        
            HStack {
                Spacer()
                
                Button(action: action) {
                    Image(.iconArrowUp)
                        .resizable()
                        .foregroundStyle(.backgroundOne)
                        .frame(width: AppSizes.h24.value,
                               height: AppSizes.h24.value)
                        .padding(AppSizes.h12.value)
                        .background(.layerOne)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .doubleShadow(.shadowOne)
                .padding(AppSizes.w16.value)
            }
        }
    }
}
