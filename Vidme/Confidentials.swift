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
        if let dictionary = Locksmith.loadDataForUserAccount(userAccount: keychainAccount, inService: keychainService) as? [String : String] {
            let token = dictionary[forType.rawValue]!
            return token
        } else {
            return nil
        }
    }

    // MARK: - Update & Create

    func update(forType: KeychainType, value: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        do {
            try Locksmith.updateData(data: [forType.rawValue : value], forUserAccount: keychainAccount, inService: keychainService)
            completion(true)
        } catch {
            completion(false)
        }
    }

    // MARK: - Delete

    func delete(completion: @escaping (_ isSuccess: Bool) -> Void) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: keychainAccount, inService: keychainService)
            completion(true)
        } catch {
            completion(false)
        }
    }

}

let keychainAccount = "Duckensburg.Vidme.Account"
let keychainService = "Duckensburg.Vidme.Service"
let keychainGroup = "Duckensburg.Vidme"

enum KeychainType: String {
    case accessToken = "access_token"
    case email = "email"
    case uuid = "uuid"
}















