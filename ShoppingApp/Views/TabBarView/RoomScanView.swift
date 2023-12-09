import SwiftUI

struct RoomScanView: View {
    @State private var isScannerViewPresented = false

    var body: some View {
        VStack {
            // Other content of your RoomScanView

            Button(action: {
                isScannerViewPresented = true
            }) {
                Image("Scanning")
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(10.0)
            }
            .fullScreenCover(isPresented: $isScannerViewPresented) {
                RoomCaptureViewControllerRepresentable()
            }
        }
    }
}

struct RoomScanView_Previews: PreviewProvider {
    static var previews: some View {
        RoomScanView()
    }
}
