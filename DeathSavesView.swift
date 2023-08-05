//
//  DeathSaveVie.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 06/07/2023.
//

import SwiftUI

struct DeathSavesView: View {
    @ObservedObject var character: Character
    @State private var isShowingDeathSavesSheet = false
    
    var body: some View {
        Button(action: {
            isShowingDeathSavesSheet.toggle()
        }) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .overlay(
                    Text("Death Saves")
                        .foregroundColor(.primary)
                )
        }
        .sheet(isPresented: $isShowingDeathSavesSheet) {
            NavigationView {
                DeathSavesSheet(character: character)
                
                
                  
                
           
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            HStack {
                                Button(action: {
                                    isShowingDeathSavesSheet = false
                                    
                                }) {
                                    Text("Cancel")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button("Reset") {
                                    character.deathSaveSuccesses = 0
                                    character.deathSaveFailures = 0
                                }
                            }
                        }
                        
                    }
            }  .presentationDetents([.fraction(0.3), .large])
                .presentationBackground(.ultraThinMaterial)
        }
    }
}

struct DeathSavesSheet: View {
    @ObservedObject var character: Character
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack {
                HStack {
                    ForEach(0..<3) { index in
                        Image(systemName: index < character.deathSaveSuccesses ? "checkmark.circle.fill" : "checkmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(character.deathSaveSuccesses == 3 ? .green : .primary.opacity(0.5))
                            .onTapGesture {
                                if character.deathSaveSuccesses < 3 {
                                    character.deathSaveSuccesses += 1
                                }
                            }
                    }
                    Text("Successes")
                }
              
            }
       
            VStack {
                HStack(){
                    ForEach(0..<3) { index in
                        Image(systemName: index < character.deathSaveFailures ? "xmark.circle.fill" : "xmark.circle")
                        
                            .resizable()
                            .foregroundColor(character.deathSaveFailures == 3 ? .red : .primary.opacity(0.5))
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                if character.deathSaveFailures < 3 {
                                    
                                    character.deathSaveFailures += 1
                                }
                                
                            }
                    }
                    Text("Failures")
                }
            }
           
            
        
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct DeathSavesViewPreview: PreviewProvider {
    static var previews: some View {
        DeathSavesView(character: Character(name: "Bard", level: 1))
    }
}

