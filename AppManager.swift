import SwiftUI
import Foundation

class AppManager: ObservableObject {
    static let shared = AppManager()
    
    @Published var isDataLoaded: Bool = false
    @Published var races: [Race] = []
    @Published var subraces: [Subrace]? = []
    
    // Store the classes data
    @Published var classes: [String: DNDClass] = [:]
    
    private init() {
        print("AppManager - Initializing...")
        // Defer the loading to ensure all properties are initialized
        DispatchQueue.main.async {
            self.loadData()
        }
    }
    
    func loadData() {
        Task {
            await preloadRaces()
            loadDNDClassesData()
            
            // Load the DND classes data
        }
    }
    
    private func preloadRaces() async {
        print("AppManager - preloading races...")
        let (loadedRaces, loadedSubraces) = await loadRacesAndSubraces()
        print("AppManager - loaded races and subraces")
        DispatchQueue.main.async {
            print("AppManager - updating races and subraces on main thread")
            self.races = loadedRaces
            self.subraces = loadedSubraces
            print("AppManager - updated races and subraces")
            self.isDataLoaded = true
        }
    }
    
    // Load DND classes
    private func loadDNDClassesData() {
        print("Loading DND classes data...")
        
        if let loadedClasses = loadDNDClasses() {
            DispatchQueue.main.async {
                self.classes = loadedClasses
                print("Successfully loaded DND classes data.")
            }
        } else {
            print("Failed to load DND classes data.")
        }
    }
}
