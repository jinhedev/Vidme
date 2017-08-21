//
//  Post.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation
import RealmSwift

final class Post: Object {

    dynamic var id = ""
    dynamic var title = ""
    dynamic var postImagePath = ""
    dynamic var created_at = NSDate()
    dynamic var updated_at = NSDate()
    dynamic var upvotes: Int = 0
    var comments = List<Comment>()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: String, title: String, postImagePath: String, created_at: NSDate, updated_at: NSDate, upvotes: Int, comments: List<Comment>) {
        self.init()
        self.id = id
        self.created_at = created_at
        self.updated_at = updated_at
        self.title = title
        self.postImagePath = postImagePath
        self.upvotes = upvotes
        self.comments = comments
    }

}
