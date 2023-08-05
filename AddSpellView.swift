import SwiftUI
import Foundation
struct AddSpellView: View {
    @EnvironmentObject var spellManager: SpellManager
    @ObservedObject var character: Character
    @State private var searchText = ""
    @Binding var isAddingSpell: Bool
    @State var selectedSpell: Spell?
 
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List {
                    ForEach(filteredSpells(), id: \.id) { (spell: Spell) in
                        NavigationLink(destination: SpellDetailView(character: character, isAddingSpell: $isAddingSpell, spell: spell)) {
                            Text(spell.name)
                        }
                    }
                }
            }
            .navigationBarTitle("Add Spell")
            }
        }
    

    func filteredSpells() -> [Spell] {
        let lowercasedSearchText = searchText.lowercased()
        return spellManager.allSpells.filter { spell in
            if lowercasedSearchText.hasPrefix("level:") {
                let levelSearchText = lowercasedSearchText.replacingOccurrences(of: "level:", with: "").trimmingCharacters(in: .whitespaces)
                return String(describing: spell.level) == levelSearchText
            }

            if lowercasedSearchText.hasPrefix("school:") {
                let schoolSearchText = lowercasedSearchText.replacingOccurrences(of: "school:", with: "").trimmingCharacters(in: .whitespaces)
                return spell.school.lowercased().contains(schoolSearchText)
            }

            let descriptionString = spell.description.map { descriptionElement in
                switch descriptionElement {
                case .string(let str):
                    return str
                case .object(let obj):
                    return obj.name ?? ""
                }
            }.joined(separator: " ")

            return searchText.isEmpty ||
                spell.name.lowercased().contains(lowercasedSearchText) ||
                descriptionString.lowercased().contains(lowercasedSearchText)
        }.sorted(by: { $0.name < $1.name })
    }
}
