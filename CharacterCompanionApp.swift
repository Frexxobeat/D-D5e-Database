//
//  CharacterCompanionApp.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 28/05/2023.
//

import SwiftUI
import UIKit
import CoreData

   
@main
struct CharacterCompanionApp: App {
    @StateObject var appManager = AppManager.shared
    @StateObject var characterManager = CharacterManager()
    @StateObject var spellManager = SpellManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appManager)
                .environmentObject(characterManager)
                .environmentObject(spellManager)
        }
    }
}
