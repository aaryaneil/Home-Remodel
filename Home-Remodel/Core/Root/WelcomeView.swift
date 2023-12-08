import SwiftUI

struct WelcomeView: View {
    @State private var navigateToLogin = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("BG")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

                VStack {
                    Spacer()

                    Text("Welcome\nto our store")
                        .font(.customfont(.semibold, fontSize: 48))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text("Step Inside Your Imagination: LiDAR-Powered Design with Neohome")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)

                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Get Started")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.green) // Set background to green
                            )
                    }
                    .buttonStyle(PlainButtonStyle())

                    NavigationLink(
                        destination: LoginView(),
                        isActive: $navigateToLogin,
                        label: { EmptyView() }
                    )
                    .hidden()

                    Spacer()
                        .frame(height: 80)
                }
                .padding(.horizontal, 20)
            }
            .ignoresSafeArea()
        }
        .onAppear {
      
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


