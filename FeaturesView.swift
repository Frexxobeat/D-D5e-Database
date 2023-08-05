//
//  FeaturesView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 16/06/2023.
//
import SwiftUI

struct FeaturesView: View {
    @StateObject var character: Character
    @ObservedObject var spellManager: SpellManager
    
//    var classData: DNDClassType? {
//        let property = Mirror(reflecting: AppManager.shared.dNDClassModel!).children.first { $0.label == character.classType.rawValue.lowercased() }
//        return property?.value as? DNDClassType
//    }
//
//    var classFeatures: [ClassFeature] {
//        classData?.classFeatures ?? []
//    }
//
//    var subclasses: [Subclass] {
//        classData?.subclasses ?? []
//    }

    
    @Binding var isAddingSpell: Bool
    @State var selectedSpell: Spell?
    @State private var customFeatures: [RaceFeature] = []
    @State private var showingAddFeature = false
    
    var body: some View {
        
        List {
            // Race Features
            Section(header: Text("Race Features")) {
                ForEach(character.race?.entries ?? [], id: \.self) { entry in
                    NavigationLink(destination: FeatureDetailView(character: character, spellManager: spellManager, isAddingSpell: isAddingSpell, entry: entry)) {
                        Text(entry.displayText)
                    }
                }
            }
            
            // Subrace Features
            if let subraceEntries = character.subrace?.entries {
                Section(header: Text("Subrace Features")) {
                    ForEach(subraceEntries, id: \.self) { entry in
                        NavigationLink(destination: SubraceFeatureDetailView(spellManager: spellManager, character: character, entry: entry)) {
                            Text(entry.displayText)
                        }
                    }
                }
            }
            
            // Class Starting Proficiencies
            
//            Section(header: Text("Class Starting Proficiencies")) {
//                
//                // Armor Proficiencies
//                ForEach(DNDClass.?.startingProficiencies.armor ?? ["None"], id: \.self) { armor in
//                    Text(armor)
//                }
//                
//                // Weapon Proficiencies
//                ForEach(classData?.startingProficiencies.weapons ?? ["None"] , id: \.self) { weapon in
//                    Text(weapon)
//                }
//                
//                //                        // Skill Proficiencies
//                //                        ForEach(classData.startingProficiencies.skills, id: \.self) { skill in
//                //                            Text(skill.choose.name)
//                //                        }
//            }
//            
//            
         
            Section(header: Text("Class Features")) {
                List(character.classType?.classFeature ?? []) { feature in
                    if feature.level <= character.level {
                        NavigationLink(destination: FeatureDetailView(character: character, spellManager: spellManager, isAddingSpell: isAddingSpell, entry: .string(feature.name))) {
                            Text(feature.name)
                        }
                    }
                }
            }

//            // Subclass Features (only if character has a subclass)
//            if let subclassTitle = character.classType.subclass{
//                let relevantSubclassFeatures = character.classType?.subclass.filter { $0.name  }
//                   
//                if !relevantSubclassFeatures.isEmpty {
//                    Section(header: Text("Subclass Features")) {
//                        ForEach(relevantSubclassFeatures, id: \.self) { subclass in
//                            NavigationLink(destination: FeatureDetailView(character: character, spellManager: spellManager, isAddingSpell: isAddingSpell, entry: .string(subclass.name))) {
//                                Text(subclass.name)
//                            }
//                        }
//                    }
//                }
//            }
            //
            // Custom Features
            Section(header: Text("Custom Features")) {
                ForEach(customFeatures) { feature in
                    NavigationLink(destination: SubraceFeatureDetailView(spellManager: spellManager, character: character, entry: .string(feature.name))) {
                        Text(feature.name)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Features")
        .navigationBarItems(trailing: Button("Add Custom Feature") {
            showingAddFeature = true
        })
        .sheet(isPresented: $showingAddFeature) {
            AddFeatureView(customFeatures: $customFeatures)
        }
        
        
    }
}
struct AddFeatureView: View {
    @Binding var customFeatures: [RaceFeature]
    @State private var featureName = ""
    @State private var featureDescription = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("Feature Details")) {
                TextField("Feature Name", text: $featureName)
                TextEditor(text: $featureDescription)
                    .frame(height: 200)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add Custom Feature")
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let newFeature = RaceFeature(name: featureName, description: featureDescription)
                    customFeatures.append(newFeature)
                    dismiss()
                }
            }
        }
    }
}





struct FeatureDetailView: View {
    
    @ObservedObject var character: Character
    @ObservedObject var spellManager: SpellManager
    @State var isAddingSpell = true
    @State var selectedSpell: Spell?
    let entry: RaceEntry
    
    var body: some View {
        VStack {
            switch entry {
            case .string(let string):
                Text(string)
                    .font(.largeTitle)
            case .purpleEntry(let purpleEntry):
                Text(purpleEntry.name ?? "")
                    .font(.largeTitle)
                if let entries = purpleEntry.entries {
                    ForEach(entries, id: \.self) { indecentEntry in
                        switch indecentEntry {
                        case .string(let string):
                            // Check if the string contains a spell name
                            if let spell = spellManager.allSpells.first(where: { string.contains($0.name) }) {
                                // Create a NavigationLink to the spell's detail view
                                NavigationLink(destination: SpellDetailView(character: character, isAddingSpell: $isAddingSpell, spell: spell)) {
                                    Text(string)
                                        .font(.body)
                                }
                            } else {
                                Text(string)
                                    .font(.body)
                                    .padding(10)
                            }
                        case .fluffyEntry(_):
                            Text("").font(.body)
                        }
                    }
                }
            }
        }
        .padding()
    }
}




struct SubraceFeatureDetailView: View {
    @ObservedObject var spellManager: SpellManager
    @ObservedObject var character: Character
    var entry: SubraceEntry
    @State private var showingSpellDetail = false
    @State private var selectedSpell: Spell?
    
    var body: some View {
        VStack(alignment: .leading) {
            // Display the title (either the string or the name of the stickyEntry)
            Text(entry.displayText)
                .font(.title)
                .padding(.bottom, 10)
            
            // Handle the body of the entry
            switch entry {
            case .string(let string):
                // If it's a string, we directly use the FeatureText view to handle it
                FeatureText(spellManager: spellManager, character: character, featureText: string)
                    .padding(.bottom, 10)
                
            case .stickyEntry(let stickyEntry):
                // If it's a stickyEntry, we just display the name (or any other detail you want from the stickyEntry)
                Text(stickyEntry.name)
                    .padding(.bottom, 10)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(entry.displayText), displayMode: .inline)
        .sheet(isPresented: $showingSpellDetail) {
            if let selectedSpell = self.selectedSpell {
                SpellDetailView(character: character, isAddingSpell: .constant(false), spell: selectedSpell)
            }
        }
    }
}


