//
//  Feature.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 16/06/2023.
//

import Foundation
struct RaceFeature: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

struct TextComponent: Identifiable {
    let id = UUID()
    let content: String
    let color: Color?
}

import SwiftUI

struct FeatureText: View {
    @ObservedObject var spellManager: SpellManager
    @ObservedObject var character: Character
    let featureText: String
    @State private var showingSpellDetail = false
    @State private var selectedSpell: Spell?
    
    func parseTextComponents(from text: String) -> [TextComponent] {
        let regexPattern = "\\{@(\\w+) ([^}]+)\\}"
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
        let nsString = text as NSString
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: nsString.length))
        
        var lastIndex = 0
        var textComponents: [TextComponent] = []
        
        for match in matches {
            let type = nsString.substring(with: match.range(at: 1))
            let value = nsString.substring(with: match.range(at: 2))
            
            // Add text before the match
            textComponents.append(TextComponent(content: nsString.substring(with: NSRange(location: lastIndex, length: match.range.location - lastIndex)), color: nil))
            
            switch type {
            case "spell":
                if spellManager.allSpells.first(where: { $0.name == value }) != nil {
                    textComponents.append(TextComponent(content: value, color: .blue))
                } else {
                    textComponents.append(TextComponent(content: value, color: nil))
                }
            case "damage", "book":
                textComponents.append(TextComponent(content: value, color: .red))
            default:
                textComponents.append(TextComponent(content: value, color: nil))
            }
            
            lastIndex = match.range.location + match.range.length
        }
        
        // Add text after the last match
        textComponents.append(TextComponent(content: nsString.substring(from: lastIndex), color: nil))
        
        return textComponents
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(parseTextComponents(from: featureText), id: \.content) { textComponent in
                if textComponent.color == .blue, let spell = spellManager.allSpells.first(where: { $0.name == textComponent.content }) {
                    Button(action: {
                        self.selectedSpell = spell
                        self.showingSpellDetail = true
                    }) {
                        Text(textComponent.content)
                            .foregroundColor(textComponent.color ?? .black)
                    }
                } else {
                    Text(textComponent.content)
                        .foregroundColor(textComponent.color ?? .black)
                }
            }
        }
        .sheet(isPresented: $showingSpellDetail) {
            if let selectedSpell = self.selectedSpell {
                SpellDetailView(character: character, isAddingSpell: .constant(false), spell: selectedSpell)
            }
        }
    }
}
