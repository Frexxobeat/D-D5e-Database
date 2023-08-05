//
//  RestedSheetView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 21/07/2023.
//

import SwiftUI


struct RestedSheet: View {
    @ObservedObject var character: Character
    @Binding var isShowingRestSheet: Bool
    
    var body: some View {
        HStack {
            Group {
                Button(action: {
                    isShowingRestSheet = true
                }) {
                    HStack {
                        Image(systemName: "zzz")
                            .font(.headline)
                        
                        Text("Rest")
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor.opacity(0.5).gradient)
                    .cornerRadius(10)
                    
                    
                }
             
                .sheet(isPresented: $isShowingRestSheet) {
                    RestSheet(character: character, isShowingRestSheet: $isShowingRestSheet)
                        .presentationDetents([.fraction(0.3), .large])
                        .presentationBackground(.ultraThinMaterial)
                }
                
                
            }
        }
    }
}
