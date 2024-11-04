import SwiftUI

/// A custom progress view with horizontal centering and a customizable color tint.

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
