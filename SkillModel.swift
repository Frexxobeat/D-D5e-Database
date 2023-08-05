//
//  SkillModel.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 16/07/2023.
//

import Foundation
import SwiftUI


class CharacterSkill: Identifiable, ObservableObject {
    let id = UUID()
    @Published var isProficient: Bool = false
    var character: Character
    
    let skillName: String

    init(character: Character, skillName: String) {
        self.character = character
        self.skillName = skillName
    }
    
    
    var modifier: Int {
               
        let statModifier = character.stats.first { $0.statName == associatedStat }?.modifier ?? 0
        return isProficient ? character.proficiencyMod + statModifier : statModifier
    }
    
    
    
    var associatedStat: String {
        switch skillName {
        case "Acrobatics", "Sleight of Hand","Thieves' Tools", "Stealth":
            return "Dexterity"
        case "Animal Handling", "Insight", "Medicine", "Perception", "Survival":
            return "Wisdom"
        case "Athletics":
            return "Strength"
        case "Deception", "Intimidation", "Performance", "Persuasion":
            return "Charisma"
        case "History", "Investigation", "Nature":
            return "Intelligence"
        default:
            return "Strength"
        }
    }
    
   

    var modifierSign: String {
        return modifier >= 0 ? "+" : ""
    }
    
    
}
