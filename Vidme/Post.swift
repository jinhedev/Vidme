//
//  Post.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation
import RealmSwift

/// the name of this model is actually called video, but to abstract the ios client further, I prefer to stick with the more generic naming convention
final class Post: Object {

    dynamic var id = ""
    dynamic var title = ""
    dynamic var postDescription = ""
    dynamic var postImagePath = ""
    dynamic var created_at = NSDate()
    dynamic var updated_at = NSDate()
    dynamic var upvotes: Int = 0
    dynamic var postVideoPath = ""
    dynamic var embeded_url = ""
    dynamic var youtube_override_source = ""
    var comments = List<Comment>()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: String, title: String, postImagePath: String, postVideoPath: String, embeded_url: String, youtube_override_source: String, created_at: NSDate, updated_at: NSDate, postDescription: String, upvotes: Int, comments: List<Comment>) {
        self.init()
        self.id = id
        self.created_at = created_at
        self.updated_at = updated_at
        self.title = title
        self.postDescription = postDescription
        self.postImagePath = postImagePath
        self.postVideoPath = postVideoPath
        self.youtube_override_source = youtube_override_source
        self.embeded_url = embeded_url
        self.upvotes = upvotes
        self.comments = comments
    }

}
