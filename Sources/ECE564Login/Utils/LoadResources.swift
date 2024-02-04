//
//  LoadResources.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import Foundation
#if canImport(UIKit)
import UIKit
import SwiftUI

func loadImage(named fileName: String, withExtension fileExtension: String) -> UIImage? {
    guard let imageURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
        print("Image file not found in the bundle")
        return nil
    }
    
    do {
        let imageData = try Data(contentsOf: imageURL)
        guard let image = UIImage(data: imageData) else {
            print("Failed to create UIImage from data")
            return nil
        }
        
        return image
    } catch {
        print("Error reading image data: \(error)")
        return nil
    }
}


func loadCustomFont(name: String, extension: String, size: CGFloat) -> Font {
    if let fontURL = Bundle.main.url(forResource: name, withExtension: `extension`) {
        do {
            let fontData = try Data(contentsOf: fontURL)
            let provider = CGDataProvider(data: fontData as CFData)
            if let font = CGFont(provider!) {
                if CTFontManagerRegisterGraphicsFont(font, nil) {
                    return Font.custom(name, size: size)
                }
            }
        } catch {
            print("Error loading font data: \(error)")
        }
    }
    
    // Fallback to a system font if the custom font cannot be loaded
    return Font.system(size: size)
}

#endif
