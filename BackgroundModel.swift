//
//  Background.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 05/07/2023.
//

import Foundation
import SwiftUI



struct CharacterBackground: Identifiable {
    var proficiencies: [String]
    let id = UUID()
    let name: String
    var features: [RaceFeature]?
    var startingGold: Int?
    var startingEquipment: [DnDItem]?
    
    
    
}
