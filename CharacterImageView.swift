import SwiftUI

struct CharacterImageView: View {
    // Singleton access to AppManager
    @EnvironmentObject var characterManager : CharacterManager
    @ObservedObject var character: Character

    // Default image for the character
    let defaultUIImage = UIImage(imageLiteralResourceName: "Johan Carpenter_Image")

    var body: some View {
        Group {
            // If character.characterImage has a value, use it, otherwise use the defaultUIImage
            Image(uiImage: character.characterImage ?? defaultUIImage)
                .resizable()
                .scaledToFit()
        }
    }
}

struct CharacterImageView_Previews: PreviewProvider {
    // Use the shared instance of AppManager for the previews
    static var previews: some View {
        @EnvironmentObject var characterManager : CharacterManager

        if let firstCharacter = characterManager.characters.first {
            return CharacterImageView(character: firstCharacter)
        } else {
            return CharacterImageView(character: Character())  // Example fallback character
        }
    }
}
