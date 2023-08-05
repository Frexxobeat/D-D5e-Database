import SwiftUI

struct SpellDetailView: View {
    @ObservedObject var character: Character
    @Binding var isAddingSpell: Bool
    let spell: Spell
    private let generator = UIImpactFeedbackGenerator(style: .light)
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(spell.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("Level: \(spell.level.displayValue)")
                        
                            .fontWeight(.medium)
                        Text("School: \(spell.school)")
                        
                            .fontWeight(.medium)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    // Displaying range
                    Group {
                        HStack {
                            
                            ForEach(spell.range, id: \.self) { rangeElement in
                                switch rangeElement {
                                case .int(let rangeInt):
                                    Text("\(rangeInt)")
                                case .string(let rangeString):
                                    Text("Range: \(rangeString)")
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    .font(.title2)
                    .foregroundColor(.secondary)
                    
                    // Displaying components
                    VStack(alignment: .leading) {
                        Text("Components:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        HStack {
                            if let components = spell.components {
                                if components.v == true {
                                    Text("V")
                                }
                                if components.s == true {
                                    Text("S")
                                }
                                if let material = spell.components?.m {
                                    switch material {
                                    case .materialClass(let materialClass):
                                        Text("Material: \(materialClass.text ?? "")")
                                        if let consume = materialClass.consume {
                                            switch consume {
                                            case .bool(let value):
                                                Text("Consumed: \(value ? "Yes" : "No")")
                                            case .string(let description):
                                                Text("Consumed: \(description)")
                                            }
                                        }
                                    case .string(let str):
                                        Text("Material: \(str)")
                                    }
                                }
                                if spell.components?.r == true {
                                    Text("R")
                                }
                            }
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Displaying description
                    Group {
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        ForEach(spell.description, id: \.self) { descriptionItem in
                            switch descriptionItem {
                            case .string(let str):
                                Text(str)
                            case .object(let obj):
                                Text(obj.name ?? "")
                            }
                        }
                        .font(.body)
                        
                    }
                    .padding(.bottom, 10)
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(spell.name), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if !isSpellAlreadyAdded(spell) {
                        DispatchQueue.main.async {
                            character.spells.append(spell)
                            isAddingSpell = false
                            generator.impactOccurred()
                        }
                    }
                }) {
                    
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                }
                .disabled(isSpellAlreadyAdded(spell))
            }
        }
    }
    
    func isSpellAlreadyAdded(_ spell: Spell) -> Bool {
        return character.spells.contains { $0.name == spell.name }
    }
}
