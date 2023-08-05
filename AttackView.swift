//
//  AttackView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 22/07/2023.
//

import SwiftUI

struct AttacksView: View {
    @ObservedObject var character: Character
    
    var body: some View {
        VStack {
            Text("Attacks View")
                .font(.largeTitle)
                .foregroundColor(.black)
            
            VStack {
                HStack {
                    Text("Attack")
                    Spacer()
                    Text("Bonus")
                    Spacer()
                    Text("Damage")
                }
                ForEach(character.attacks.indices, id: \.self) { index in
                    HStack {
                        TextField("Attack \(index + 1)", text: $character.attacks[index].name)
                        Spacer()
                        TextField("Bonus \(index + 1)", text: $character.attacks[index].bonus)
                        Spacer()
                        TextField("Damage \(index + 1)", text: $character.attacks[index].damage)
                    }
                    .onChange(of: character.attacks.last) { _ in
                        if let last = character.attacks.last, !last.isEmpty {
                            character.attacks.append(Attack())
                        }
                    }
                }
            }
            .padding()
        }
    }
}


struct Attack: Identifiable, Equatable {
    var id = UUID()
    var name: String = ""
    var bonus: String = ""
    var damage: String = ""
    
    var isEmpty: Bool {
        name.isEmpty && bonus.isEmpty && damage.isEmpty
    }
}

