//
//  AncestryLoader.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 14/06/2023.
//

import Foundation
func loadRacesAndSubraces() async -> (races: [Race], subraces: [Subrace]?) {
    var races = [Race]()
    var subraces: [Subrace]?
    
    if let url = Bundle.main.url(forResource: "races_unique", withExtension: "json") {
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let racesData = try decoder.decode(Races.self, from: jsonData)
            
            races = racesData.race
            
            // Use optional binding instead of force unwrapping
            if let loadedSubraces = racesData.subrace, !loadedSubraces.isEmpty {
                subraces = loadedSubraces
            }
            
        } catch {
            print("Error: \(error)")
        }
    } else {
        print("No file found")
    }
    
    return (races, subraces)
}
