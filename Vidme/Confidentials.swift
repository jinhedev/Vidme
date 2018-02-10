//
//  Confidentials.swift
//  Vidme
//
//  Created by rightmeow on 8/22/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation
import Locksmith

class Confidentials: NSObject {

    static let shared = Confidentials()

    // MARK: - Fetch

    func fetch(forType: KeychainType) -> String? {
        if let dictionary = Locksmith.loadDataForUserAccount(userAccount: KeychainSettings.keychainAccount, inService: KeychainSettings.keychainService) as? [String : String] {
            let token = dictionary[forType.rawValue]!
            return token
        } else {
            return nil
        }
    }

    // MARK: - Update & Create

    func update(forType: KeychainType, value: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        do {
            try Locksmith.updateData(data: [forType.rawValue : value], forUserAccount: KeychainSettings.keychainAccount, inService: KeychainSettings.keychainService)
            completion(true)
        } catch {
            completion(false)
        }
    }

    // MARK: - Delete

    func delete(completion: @escaping (_ isSuccess: Bool) -> Void) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: KeychainSettings.keychainAccount, inService: KeychainSettings.keychainService)
            completion(true)
        } catch {
            completion(false)
        }
    }

}

struct KeychainSettings {
    static let keychainAccount: String = "Duckensburg.Vidme.Account"
    static let keychainService: String = "Duckensburg.Vidme.Service"
    static let keychainGroup: String = "Duckensburg.Vidme"
}

enum KeychainType: String {
    case accessToken = "access_token"
    case email = "email"
}















