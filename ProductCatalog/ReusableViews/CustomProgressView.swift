import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.accentOne))
            Spacer()
        }
    }
}
