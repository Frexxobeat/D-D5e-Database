import SwiftUI
struct SpellBook: View {
    @EnvironmentObject var spellManager: SpellManager
    @ObservedObject var character: Character
    @Binding var isAddingSpell: Bool
    @State private var selectedSpell: Spell?
    @State private var showDetailView = false
    @State private var searchText = ""
    
    @State private var isCheckingSpellSlot = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Spell Book")
                .font(.largeTitle)
                .frame(alignment: .topLeading)
                .foregroundColor(.black)
            
            ScrollView {
                VStack(spacing: 10) {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    ForEach(character.spells.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }, id: \.name) { spell in
                        NavigationLink(destination: SpellDetailView(character: character, isAddingSpell: $isAddingSpell, spell: spell)) {
                            HStack {
                                Text(spell.name)
                                    .font(.headline)
                                Spacer()
                                Text("Level \(spell.level.displayValue)")
                                    .font(.subheadline)
                                    .opacity(0.5)
                            }
                            .padding()
                            .background(Color.accentColor.opacity(0.1).gradient)
                            .cornerRadius(8)
                        }
                    }

                }
            }
            
            // "Add Spell" button
            Button(action: {
                isAddingSpell = true
            }) {
                Text("Add Spell")
            }
            .sheet(isPresented: $isAddingSpell) {
                AddSpellView(character: character, isAddingSpell: $isAddingSpell)
            }
            
            Button(action: {
                isCheckingSpellSlot = true
            }) {
                Text("Spell Slots")
            }
            .sheet(isPresented: $isCheckingSpellSlot) {
                SpellSlotsView(character: character)
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showDetailView) {
            if let spell = selectedSpell {
                SpellDetailView(character: character, isAddingSpell: $isAddingSpell, spell: spell)
            }
        }
    }
}

struct Previews_SpellBook_Previews: PreviewProvider {
    static var previews: some View {
        let spellManager = SpellManager()
        let character = Character(name: "John Doe", maxHP: 100, currentHP: 80)
        return SpellBook(character: character, isAddingSpell: .constant(false))
            .environmentObject(spellManager)
            .environmentObject(character)
    }
}
