//
//  SpellSlotsView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 04/07/2023.
//

import SwiftUI

struct SpellSlotsView: View {
    @ObservedObject var character: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(1...(character.maxSpellLevel ?? 0), id: \.self) { level in
                VStack(alignment: .leading, spacing: 10) {
                    Text("Level \(level)")
                        .font(.headline)
                    
                    HStack {
                        ForEach(0..<character.spellSlots(for: level), id: \.self) { index in
                            SpellSlotButton(isSpent: Binding(
                                get: { character.spellSlotIsSpent[level, default: [Bool]()][safe: index] ?? false },
                                set: { newValue in
                                    if character.spellSlotIsSpent[level, default: [Bool]()].indices.contains(index) {
                                        character.spellSlotIsSpent[level, default: [Bool]()][index] = newValue
                                    }
                                }
                            ))
                        }
                    }

                }
            }
        }
        .padding()
    }
}

struct SpellSlotButton: View {
    @Binding var isSpent: Bool
    
    var body: some View {
        Button(action: {
            isSpent.toggle()
        }) {
            Image(systemName: isSpent ? "xmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isSpent ? .red : .green)
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


struct SpellProgression {
    let progression: [[Int]]
    
    func slots(forCharacterLevel characterLevel: Int, spellLevel: Int) -> Int {
        guard characterLevel > 0, spellLevel > 0,
              characterLevel <= progression.count,
              spellLevel <= progression[0].count else {
            return 0
        }
        return progression[characterLevel - 1][spellLevel - 1]
    }
}
