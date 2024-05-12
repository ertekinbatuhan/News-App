//
//  ThemeManager.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 11.03.2024.
//

import Foundation
import UIKit

class ThemeManager {
    static let shared = ThemeManager()

    private init() {}

    var isDarkModeEnabled: Bool = false {
        didSet {
            updateTheme()
        }
    }
    
    func updateTheme() {
        if isDarkModeEnabled {
            applyDarkMode()
        } else {
            applyLightMode()
        }
    }

    private func applyDarkMode() {
    
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
    }

    private func applyLightMode() {
         UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
    }
    
    func updateContentViewBackgroundColor(_ contentView: UIView) {
           
            if isDarkModeEnabled {
                contentView.backgroundColor = .black
            } else {
                contentView.backgroundColor = .white
            }
        }
}

