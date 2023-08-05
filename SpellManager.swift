import Foundation

class SpellManager: ObservableObject {
    
    @Published var allSpells: [Spell] = []
    
    @Published var loadingError: String?
    @Published var spellSlots: [SpellSlot] = []
    @Published var maxSpellLevel: Int = 9
    @Published var spellSlotIsSpent: [Int: [Bool]] = [:]
    var hasLoadedSpells = false
    @Published var isDataLoaded: Bool = false

  

    
    
    func useSpellSlot(ofLevel level: Int) {
        guard let index = spellSlots.firstIndex(where: { $0.level == level && $0.isAvailable }) else {
            print("No available spell slots of level \(level)")
            return
        }
        
        spellSlots[index].isAvailable = false
    }
    
    func resetSpellSlots() {
        for index in spellSlots.indices {
            spellSlots[index].isAvailable = true
        }
    }
    
    
    func loadSpellsIfNeeded() {
        print("loading spells... if needed")
        guard !hasLoadedSpells else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            // Load spells
            if let url = Bundle.main.url(forResource: "spells", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    do {
                        let spells = try decoder.decode([Spell].self, from: data)
                        DispatchQueue.main.async {
                            self?.allSpells = spells
                            print("Loaded \(spells.count) spells from spells.json")
                            self?.hasLoadedSpells = true // Only set to true after successfully loading spells
                        }
                    } catch {
                        DispatchQueue.main.async {
                            print("Error loading spells from spells.json: \(error)")
                            self?.loadingError = "There was an error loading the spell data."
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Could not find file spells.json")
                        self?.loadingError = "Could not find the spell data file."
                    }
                }
            }
        }
    }
}
