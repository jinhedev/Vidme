//
//  Comment.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation
import RealmSwift

final class Comment: Object {

    dynamic var id = ""
    dynamic var username = ""
    dynamic var text = ""
    dynamic var created_at = NSDate()
    dynamic var updated_at = NSDate()
    dynamic var upvotes: Int = 0
    let owners = LinkingObjects(fromType: Post.self, property: "comments")

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: String, username: String, text: String, created_at: NSDate, updated_at: NSDate, upvotes: Int) {
        self.init()
        self.id = id
        self.username = username
        self.created_at = created_at
        self.updated_at = updated_at
        self.upvotes = upvotes
        self.text = text
    }
    
}
