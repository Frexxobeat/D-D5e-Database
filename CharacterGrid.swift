//
//  CharacterGrid.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 02/06/2023.
//

import SwiftUI
struct CharacterGrid: View {
    @EnvironmentObject var characterManager: CharacterManager
    
    @State private var isAddingCharacter = false
    @State private var isEditing = false
    @State private var numColumns = 1
    
    private var gridColumns: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 1, maximum: 3 )), count: numColumns)
    }
    
    private func remove(at offsets: IndexSet) {
        characterManager.characters.remove(atOffsets: offsets)
    }
    
    var body: some View {
        TabView {
            ForEach(characterManager.characters, id: \.id) { character in
                NavigationView {
                    VStack {
                        NavigationLink(destination: CharacterView(character: character)) {
                            CharacterCard(character: character)
                                .shadow(radius: 5)
                        }
                        .overlay(alignment: .topTrailing) {
                            if isEditing {
                                Button(action: {
                                    remove(at: IndexSet(integer: characterManager.characters.firstIndex(of: character)!))
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(.white, Color.accentColor.opacity(0.7))
                                        .offset(x: -15, y: 15)
                                }
                            }
                        }
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .navigationTitle("Characters")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    isAddingCharacter = true
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $isAddingCharacter) {
            NewCharacterView(newCharacter: Character())
                .environmentObject(characterManager)
        }
    }
    
    struct CharacterGrid_Previews: PreviewProvider {
        static var previews: some View {
            let data = CharacterManager()
            let spellManager = SpellManager()
            
            CharacterGrid()
                .environmentObject(data)
                .environmentObject(spellManager)
        }
    }
}
