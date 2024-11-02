import SwiftUI

struct LoadingView: View {
    @State private var loading = false
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.accentOne)
                    .frame(width: 10, height: 10)
                    .scaleEffect(loading ? 1.5 : 0.5)
                    .animation(
                        .easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                        value: loading
                    )
            }
        }
        .frame(width: 100, height: 50, alignment: .center)
        .onAppear {
            DispatchQueue.main.async {
                loading = true
            }
        }
    }
}
