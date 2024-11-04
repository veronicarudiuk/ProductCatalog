import SwiftUI

extension View {
    func showAlert(model: Binding<AlertError?>) -> some View {
        self.modifier(AlertViewModifier(model: model))
    }
}

struct AlertViewModifier: ViewModifier {
    @Binding private var model: AlertError?
    
    init(model: Binding<AlertError?>) {
        self._model = model
    }
    
    func body(content: Content) -> some View {
        content
            .alert(item: $model) { model in
                Alert(
                    title: Text(alert: .error),
                    message: Text(model.message),
                    dismissButton: model.alertButton)
            }
    }
}
