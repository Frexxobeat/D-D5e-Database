import Foundation
import SwiftUI

class CharacterManager: ObservableObject {
    @Published var characters: [Character] = []
    @EnvironmentObject var appManager: AppManager

    
    init() {
        // First, initialize the characters to an empty array to make sure all stored properties are set
        self.characters = []
        
        // Then, use the instance property 'races'
        // let humanRace = appManager.races.first { $0.name == "Human" } ?? Character.defaultFallbackRace
        
        //        self.characters = [
        //            Character(name: "Rezir Dreadfang", maxHP: 82, currentHP: 60, race: humanRace, classType: .artificer, level: 10, background: CharacterBackground(proficiencies: ["Intimidation", "Religion"], name: "Noble"), features: [Feature(name: "Relentless Rage", description: "Starting at 11th Level, your rage can keep you fighting despite grievous wounds.")])
        //        ]
        //    }
    }


    
    func createNewCharacter() -> Character {
        let newCharacter = Character()
        characters.append(newCharacter)
        print("appended \(newCharacter)")
        return newCharacter
    }

    func updateLevel(for character: Character, to newLevel: Int) {
        guard let index = characters.firstIndex(of: character) else {
            return
        }
        characters[index].level = newLevel
    }
    
    
    
    func updateStatValue(for character: Character, statIndex: Int, newValue: Int, proficiencyMod: Int) {
        if let index = characters.firstIndex(of: character) {
            if statIndex >= 0 && statIndex < characters[index].stats.count {
                characters[index].stats[statIndex].value = newValue
                
               
            } else {
                print("Invalid stat index.")
            }
        } else {
            print("Character not found.")
        }
    }
}
