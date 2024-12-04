import SwiftUI

/// Tracks scroll position and displays a "scroll to top" button if the user has scrolled down.
/// Provides a scrollable content area and updates state based on scroll offset.

struct ScrollTrackingView<Content: View>: View {
    @Binding var isScrolledDown: Bool
    @State private var showScrollToTopButton = false
    @Binding var offset: CGFloat?
    
    let content: Content
    
    private let scrollThreshold: CGFloat = 40 // Threshold for toggling scroll state
    private let idTop: String = "top"
    private let idScroll: String = "scroll"
    
    init(isScrolledDown: Binding<Bool>,
         offset: Binding<CGFloat?>? = nil,
         @ViewBuilder content: () -> Content) {
        self._isScrolledDown = isScrolledDown
        self._offset = offset ?? .constant(nil)
        self.content = content()
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        Color.clear
                            .frame(height: 0)
                            .id(idTop)
                        
                        GeometryReader { geometry in
                            Color.clear
                                .frame(height: 0)
                                .onChange(of: geometry.frame(in: .named(idScroll)).minY) { value in
                                    offset = value
                                    if value < -scrollThreshold {
                                        isScrolledDown = true
                                        showScrollToTopButton = true
                                    } else if value >= 0 {
                                        isScrolledDown = false
                                        showScrollToTopButton = false
                                    } else if value > -scrollThreshold {
                                        isScrolledDown = true
                                        showScrollToTopButton = false
                                    }
                                }
                        }
                        .frame(height: 0)
                        
                        content
                    }
                }
                .coordinateSpace(name: idScroll)
                
                // Button to scroll back to the top if scrolled down
                if showScrollToTopButton {
                    ArrowUpButton {
                        withAnimation {
                            proxy.scrollTo(idTop, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}
