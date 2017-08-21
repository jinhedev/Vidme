//
//  RealmManager.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation
import RealmSwift

protocol PersistentContainerDelegate {
    func containerDidErr(error: Error)
    func containerDidFetchPosts(posts: Results<Post>?)
    func containerDidUpdatePost()
    func containerDidDeletePost()

    func containerDidUpdateComment()
    func containerDidDeleteComment()
}

extension PersistentContainerDelegate {
    func containerDidFetchPosts(posts: Results<Post>?) {}
    func containerDidUpdatePost() {}
    func containerDidDeletePost() {}

    func containerDidUpdateComment() {}
    func containerDidDeleteComment() {}
}

var realm = try! Realm()

class RealmManager: NSObject {

    var delegate: PersistentContainerDelegate?

    // MARK: - Database wildcard methods

    func pathForContainer() -> URL {
        if let path = Realm.Configuration.defaultConfiguration.fileURL {
            return path
        } else {
            print(trace(file: #file, function: #function, line: #line))
            fatalError("No realm database found")
        }
    }

    func deleteDatabase() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let err {
            delegate?.containerDidErr(error: err)
        }
    }

    // MARK: - Get

    func fetchPosts() {
        let posts = realm.objects(Post.self).sorted(byKeyPath: "upvotes", ascending: false)
        delegate?.containerDidFetchPosts(posts: posts)
    }

    // MARK: - Update & Create

    // MARK: - Delete

}






















