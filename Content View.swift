import SwiftUI

struct ContentView: View {
   
    // We don't need to pass appManager anymore
    var newCharacter: Character {
        Character()
    }
    
    @StateObject var character = Character()

    var body: some View {
        NavigationSplitView(sidebar: {
            CharacterGrid()
                .environmentObject(AppManager.shared)
                .navigationViewStyle(StackNavigationViewStyle())
        }, detail: {
            CharacterView(character: character)
        })
    }
}
