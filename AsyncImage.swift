//
//  AsyncImage.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 16/06/2023.
//

import SwiftUI

struct AsyncImage: View {
    @State private var image: Image? = nil
    let placeholderImageName: String
    let imageData: Data?

    init(placeholderImageName: String, imageData: Data?) {
        self.placeholderImageName = placeholderImageName
        self.imageData = imageData
    }

    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
            } else {
                Image(placeholderImageName)
                    .resizable()
            }
        }
        .onAppear(perform: loadImage)
    }

    private func loadImage() {
        guard let imageData = imageData else { return }

        DispatchQueue.global(qos: .userInitiated).async {
            if let uiImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                }
            }
        }
    }
}


