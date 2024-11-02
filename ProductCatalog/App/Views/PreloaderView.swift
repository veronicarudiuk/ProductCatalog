import SwiftUI

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

struct PreloaderView_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderView()
    }
}
