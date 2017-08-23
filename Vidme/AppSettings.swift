//
//  AppSettings.swift
//  Vidme
//
//  Created by rightmeow on 8/22/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation

class AppSettings: NSObject {

    static let shared = AppSettings()

    // MARK: - Onboarding

    let onboardingCompletionKey = "onboardingComplete"

    func isOnboardingCompleted() -> Bool {
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: onboardingCompletionKey)
        if isOnboardingCompleted == true {
            return true
        } else {
            return false
        }
    }

    func setOnboardingCompletion(isCompleted: Bool) {
        UserDefaults.standard.set(isCompleted, forKey: onboardingCompletionKey)
    }

    // MARK: - Default Filter

    // MARK: - Default Sort
    
    // ...
    
}
