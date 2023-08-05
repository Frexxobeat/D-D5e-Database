import SwiftUI

struct RestSheet: View {
    @ObservedObject var character: Character
    @Binding var isShowingRestSheet: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()  // Pushes the content below towards the center
            
            Text("Choose Rest Type")
                .font(.headline)
                .padding(.top)
            
            HStack {
                Button(action: {
                    // Handle short rest logic here
                }) {
                    HStack {
                        Image(systemName: "moon.stars")
                        Text("Short Rest")
                    }
                    .padding()
                    .background(Color.accentColor.gradient)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                Button(action: {
                    // Handle long rest logic here
                }) {
                    HStack {
                        Image(systemName: "bed.double")
                        Text("Long Rest")
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
            
            Spacer()  // Pushes the content above towards the center
            
            // Cancel button
            Button(action: {
                isShowingRestSheet.toggle()
            }) {
                Text("Cancel")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
        }
        .padding(.top)
    }
}
