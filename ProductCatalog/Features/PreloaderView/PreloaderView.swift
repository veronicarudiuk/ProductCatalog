import SwiftUI

/// A view that displays a preloader screen with a loading animation.
/// Used as a temporary screen while data is being loaded in the app.

struct PreloaderView: View {

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.layerOne)
                        .frame(width: 120, height: 120)
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                LoadingView()
                    .frame(height: AppSizes.screenHeight.value / 2)
            }
        }
        .setBGColor()
    }
}
