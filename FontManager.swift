//
//  FontManager.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 11/29/24.
//

import UIKit

class FontManager {
    static let shared = FontManager()
    
    private init() {}
    
    var selectedFont: String = "Papyrus" {
        didSet {
            NotificationCenter.default.post(name: .fontChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let fontChanged = Notification.Name("fontChanged")
}

