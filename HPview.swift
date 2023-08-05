import SwiftUI
import Combine


struct HPView: View {
    
    @ObservedObject var viewModel: HPViewViewModel
    
    var body: some View {
        
        
        
        HStack {
            viewModel.decrementButton
            Spacer()
            viewModel.hpView
            Spacer()
            viewModel.incrementButton
            
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding()
        .background(.bar)
        .cornerRadius(8)
        .shadow(color: .secondary.opacity(0.3), radius: 8)
        
    }
}

