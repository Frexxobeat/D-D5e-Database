
import SwiftUI
import UIKit

struct CharacterView: View {
    var character: Character
    @EnvironmentObject var data: CharacterManager
    @EnvironmentObject var spellManager: SpellManager
    
    // Access the shared instance of AppManager
    let appManager = AppManager.shared
    
    
    
    @State private var isAddingSpell = false
    @State private var isEditing = false
    
    var body: some View {
        TabView {
            CharacterDetails(isEditing: $isEditing)
                .environmentObject(character)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Character")
                }
                .tag(0)
            
            AttacksView(character: character)
                .tabItem {
                    Image(systemName: "burst.fill")
                    Text("Attacks")
                }
                .tag(1)
            
            SpellBook(character: character, isAddingSpell: $isAddingSpell)
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Spells")
                }
                .tag(2)
            
            
            FeaturesView(character: character, spellManager: spellManager, isAddingSpell: $isAddingSpell)
                .tabItem {
                    Image(systemName: "hammer")
                    Text("Features")
                }
                .tag(3)
            
            InventoryView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Inventory")
                }
                .tag(4)
        }
        .onAppear {
            spellManager.loadSpellsIfNeeded()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(isEditing ? "Save" : "Edit") {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
            }
        }
    }
}


struct InventoryView: View {
    var body: some View {
        VStack {
            Text("Inventory View")
                .font(.largeTitle)
                .foregroundColor(.black)
            
            // 2 columns of fillable text fields with four separate text fields in an HStack for each kind of coin in D&D
            // Example:
            HStack {
                VStack {
                    TextField("Platinum", text: .constant(""))
                    TextField("Gold", text: .constant(""))
                }
                
                VStack {
                    TextField("Silver", text: .constant(""))
                    TextField("Copper", text: .constant(""))
                }
            }
            .padding()
        }
    }
}





