//
//  CharacterImageModel.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 17/07/2023.
//

import SwiftUI
import PhotosUI

/// A view model that integrates a Photos picker.
@MainActor final class CharacterImageModel: ObservableObject {
    
    @Published private var selectedImage: UIImage? = nil
    @Published private var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.cannotOpenFile)
                }
                
                selectedImage = uiImage
                
            } catch {
                print(error)
            }
        }
    }
}
