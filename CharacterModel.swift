//
//  Character.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 03/06/2023.
//

import Foundation
import SwiftUI
import PhotosUI

class Character: Identifiable, Equatable, ObservableObject {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var name: String = ""
    
    
    
    
    @Published var maxHP: Int
    @Published var currentHP: Int
    @Published var characterImage: UIImage?
    
    @Published var race: Race?
    @Published var speed: Int
    @Published var subrace: Subrace?
    @Published var classType: DNDClass?
    @Published var className: String?
    var spellcasting: Spellcasting? {
        return classType?.spellcasting
    }

  

    @Published var level: Int
    @Published var background: CharacterBackground {
        didSet {
            updateSkillsForBackground()
        }
    }
    @Published var attacks: [Attack] = [Attack()]
    @Published var spells: [Spell] = []
    @Published var spellSlots: [SpellSlot] = []
    @Published var maxSpellLevel: Int?
    @Published var spellProgression: SpellProgression?
    @Published var spellSlotIsSpent: [Int: [Bool]] = [:]
    @Published var inventory: [DnDItem] = []
    @Published var features: [RaceFeature] = []
    @Published var deathSaveSuccesses: Int = 0
    @Published var deathSaveFailures: Int = 0
    @Published var stats = [
        Stat(statName: "Strength", value: 10),
        Stat(statName: "Dexterity", value: 10),
        Stat(statName: "Constitution", value: 10),
        Stat(statName: "Intelligence", value: 10),
        Stat(statName: "Wisdom", value: 10),
        Stat(statName: "Charisma", value: 10)
    ]
    @Published var skills: [CharacterSkill] = []
    
    init(name: String = "",
             maxHP: Int = 10,
             currentHP: Int = 10,
             race: Race =  Character.defaultFallbackRace,
             classType: DNDClass? = nil,  // set the default to nil
             level: Int = 1,
             background: CharacterBackground = CharacterBackground(proficiencies: ["Survival", "Persuasion"], name: "Sailor", startingGold: 50),
             speed: Int = 30,
             spells: [Spell] = [],
         spellSlots: [SpellSlot] = [],
         maxSpellLevel: Int = 9,
         spellProgression: SpellProgression? = nil,
         characterImage: UIImage = UIImage(imageLiteralResourceName: "Johan Carpenter_Image" ),
         spellSlotIsSpent: [Int : [Bool]] = [:],
         features: [RaceFeature] = []) {
        
        
        
        self.name = name
        self.maxHP = maxHP
        self.currentHP = currentHP
        self.race = race
        self.classType = classType
        self.level = level
        self.background = background
        self.speed = speed
        self.spells = spells
        self.spellSlots = spellSlots
        self.maxSpellLevel = maxSpellLevel
        self.spellProgression = spellProgression
        self.characterImage = characterImage
        self.features = features
        
        self.skills = [
            CharacterSkill(character: self, skillName: "Acrobatics"),
            CharacterSkill(character: self, skillName: "Animal Handling"),
            CharacterSkill(character: self, skillName: "Athletics"),
            CharacterSkill(character: self, skillName: "Deception"),
            CharacterSkill(character: self, skillName: "History"),
            CharacterSkill(character: self, skillName: "Insight"),
            CharacterSkill(character: self, skillName: "Intimidation"),
            CharacterSkill(character: self, skillName: "Investigation"),
            CharacterSkill(character: self, skillName: "Medicine"),
            CharacterSkill(character: self, skillName: "Nature"),
            CharacterSkill(character: self, skillName: "Perception"),
            CharacterSkill(character: self, skillName: "Performance"),
            CharacterSkill(character: self, skillName: "Persuasion"),
            CharacterSkill(character: self, skillName: "Religion"),
            CharacterSkill(character: self, skillName: "Sleight of Hand"),
            CharacterSkill(character: self, skillName: "Stealth"),
            CharacterSkill(character: self, skillName: "Survival")
        ]
        
        
        
    }
    
    //Armorclass calculation
    var armorClass: Int {
        // Example formula: armorClass = 10 + dexterity modifier
        // Assuming dexterity modifier is (dexterity - 10) / 2
        let dexterityValue = stats.first { $0.statName == "Dexterity" }?.value ?? 10
        let dexterityModifier = (dexterityValue - 10) / 2
        return 10 + dexterityModifier
    }
    
    
    
    func spellSlots(for level: Int) -> Int {
        // Use the spellProgression data to determine the number of spell slots
        return spellProgression?.slots(forCharacterLevel: self.level, spellLevel: level) ?? 0
    }
    
    
    
    
    func updateSkillsForBackground() {
        for skillName in background.proficiencies {
            if let index = skills.firstIndex(where: { $0.skillName == skillName }) {
                skills[index].isProficient = true
            }
        }
    }
    
}



struct SpellSlot: Identifiable {
    let id = UUID()
    let level: Int
    var isAvailable: Bool
}

extension Character {
    var proficiencyMod: Int {
        switch level {
        case 1...4:
            return 2
        case 5...8:
            return 3
        case 9...12:
            return 4
        case 13...16:
            return 5
        case 17...20:
            return 6
        default:
            return 2
        }
    }
}


extension Character {
    func addItem(_ item: DnDItem) {
        inventory.append(item)
    }
    
    func removeItem(_ item: DnDItem) {
        inventory.removeAll { $0.name == item.name }
    }
    
    
}


extension Character {
    static var defaultFallbackRace: Race {
        // Create and return a default Race here
        return Race(name: "Unknown", source: "", page: 0, size: [], speed: nil, ability: nil, traitTags: [], languageProficiencies: [], entries: [], otherSources: [], reprintedAs: [], age: nil, soundClip: nil, hasFluff: false, hasFluffImages: false, lineage: nil, additionalSpells: nil, darkvision: nil, resist: nil, versions: nil, heightAndWeight: nil, skillProficiencies: nil, creatureTypes: nil, creatureTypeTags: nil, toolProficiencies: nil, conditionImmune: nil, copy: nil, feats: nil, srd: nil, basicRules: nil, weaponProficiencies: nil, additionalSources: nil, blindsight: nil, immune: nil, armorProficiencies: nil, vulnerable: nil)
    }
}
