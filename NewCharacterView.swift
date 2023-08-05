import SwiftUI
import PhotosUI

struct NewCharacterView: View {
    @ObservedObject var newCharacter: Character
    @EnvironmentObject var characterManager: CharacterManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isEditing: Bool = true
    @State private var currentTab: Int = 0
    @State private var selectedClass: String = "fighter"
    
    @State private var level: Int = 1
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                
                // Tab 1: Basics
                Form {
                    Section(header: Text("Name")) {
                        TextField("Name", text: $newCharacter.name)
                    }
                    Section(header: Text("Class")) {
                                 ClassPickerView(selectedClass: $selectedClass)
                             }
                    Section(header: Text("Ancestry")) {
                        RaceSubracePickerView(selectedRace: $newCharacter.race, selectedSubrace: $newCharacter.subrace)
                    }
                    Section(header: Text("Level")) {
                        Stepper("Level", value: $newCharacter.level, in: 1...20)
                    }
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Basics")
                }
                .tag(0)
                
                // Tab 2: Stats
                Form {
                    ForEach(newCharacter.stats.indices, id: \.self) { index in
                        StatView(stat: $newCharacter.stats[index], isEditing: true)
                    }
                }
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
                .tag(1)
                
                .tabItem {
                    Image(systemName: "graduationcap.fill")
                    Text("Skills")
                }
                .tag(2)
                // Tab 3: Background
                VStack {
                    Text("Background selection coming soon")
                }
                
                SkillsSheet(character: newCharacter, isEditing: $isEditing)
                
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Background")
                }
                .tag(3)
                
                // Tab 4: Image
                CharacterImagePickerView()
                    .tabItem {
                        Image(systemName: "photo.fill")
                        Text("Image")
                    }
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        characterManager.characters.append(newCharacter)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct CharacterImagePickerView: View {
    @StateObject private var viewmodel = CharacterImageModel()
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var showingUpgradeSheet = false
    @State private var isShowingStore = false
    
    var body: some View {
        Form {
            Section(header: Text("Character Photo")) {
                PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
                
                if let avatarImage = avatarImage {
                    avatarImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                }
            }
            .onChange(of: avatarItem) { _ in
                Task {
                    if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            avatarImage = Image(uiImage: uiImage)
                            return
                        }
                    }
                }
            }
            
            Button("Generate Art") {
                showingUpgradeSheet = true
            }
            .sheet(isPresented: $showingUpgradeSheet) {
                VStack {
                    Text("Upgrade to Pro")
                        .font(.largeTitle.bold())
                        .padding()
                        .foregroundColor(.accentColor)
                    Text("Unlock the ability to generate character art and more with the Pro version.")
                    Button(action: {
                        isShowingStore = true
                    }, label: {
                        Text("Take my money!")
                    })
                }
                .padding()
                .sheet(isPresented: $isShowingStore, content: {
                    Text("Thank you for showing interest, currently, we don't have it quite ready yet, but sign up for the newsletter for more details!")
                    Button("Yes, Please!", action: { isShowingStore = false })
                })
                .padding()
                .frame(width: 240, height: 340)
            }
        }
    }
}
struct ClassPickerView: View {
    @Binding var selectedClass: String  // Use String type
    let characterClasses = Array(AppManager.shared.classes.keys)  // Use class names from AppManager
    
    var body: some View {
        Picker("Class", selection: $selectedClass) {
            ForEach(characterClasses, id: \.self) { characterClass in
                Text(characterClass).tag(characterClass)
            }
        }
    }
}


struct RaceSubracePickerView: View {
    @Binding var selectedRace: Race?
    @Binding var selectedSubrace: Subrace?
    
    let races = AppManager.shared.races
    let subraces = AppManager.shared.subraces
    
    var filteredSubraces: [Subrace] {
        return subraces?.filter {
            $0.raceName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == selectedRace?.name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        } ?? []
    }
    
    var body: some View {
        Group {
            RacePickerView(selectedRace: $selectedRace, races: races)
            
            if !filteredSubraces.isEmpty {
                SubracePickerView(selectedSubrace: $selectedSubrace, subraces: filteredSubraces)
            }
        }
    }
}
struct RacePickerView: View {
    @Binding var selectedRace: Race?
    let races: [Race]
    
    var body: some View {
        Picker(selection: $selectedRace, label: Text("Ancestry")) {
            Text("Select an ancestry") // Placeholder
            ForEach(races, id: \.self) { race in
                Text(race.name).tag(race as Race?)
            }
        }
    }
}
struct SubracePickerView: View {
    @Binding var selectedSubrace: Subrace?
    let subraces: [Subrace]
    
    var body: some View {
        Picker("Subrace", selection: $selectedSubrace) {
            Text("Select a Subrace") // Placeholder
            ForEach(subraces, id: \.name) { subrace in
                Text(subrace.name ?? "").tag(Optional(subrace))
            }
        }
    }
}
