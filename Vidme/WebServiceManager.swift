//
//  WebServices.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

protocol WebServiceDelegate {
    func webServiceDidErr(error: Error)
    // posts
    func webServiceDidFetchPosts(posts: [NSDictionary])
    func webServiceDidCreatePost(post: NSDictionary)
    func webServiceDidUpdatePost(post: NSDictionary)
    func webServiceDidDeletePost()
    // user(s)
    // comments
    func webServiceDidFetchComments(comments: [NSDictionary])
    // ...
}

extension WebServiceDelegate {
    // posts
    func webServiceDidFetchPosts(posts: [NSDictionary]) {}
    func webServiceDidCreatePost(post: NSDictionary) {}
    func webServiceDidUpdatePost(post: NSDictionary) {}
    func webServiceDidDeletePost() {}
    // user(s)
    // comments
    func webServiceDidFetchComments(comments: [NSDictionary]) {}
    // ...
}

class WebServiceManager {

    var delegate: WebServiceDelegate?

    // MARK: - GET

    func fetchPosts(type: VideoSort) {
        let url = configureURL(endpoint: type.rawValue)
        Alamofire.request(url, method: HTTPMethod.get, parameters: parammeters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
            guard response.result.isSuccess else {
                let error = response.result.error!
                self.delegate?.webServiceDidErr(error: error)
                return
            }
            guard let json = response.result.value as? [String : Any], let posts = json["videos"] as? [NSDictionary] else {
                print("failed to parse response into [String : Any]")
                return
            }
            // handle success
            self.delegate?.webServiceDidFetchPosts(posts: posts)
        }
    }

    func fetchComments(type: CommentSort, video_id: String) {
        let url = configureURL(endpoint: type.rawValue)
        var videoParam = parammeters
        videoParam["video"] = video_id
        Alamofire.request(url, method: HTTPMethod.get, parameters: videoParam, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
            guard response.result.isSuccess else {
                let error = response.result.error!
                self.delegate?.webServiceDidErr(error: error)
                return
            }
            guard let json = response.result.value as? [String : Any], let comments = json["comments"] as? [NSDictionary] else {
                print("failed to parse response into [String : Any]")
                return
            }
            self.delegate?.webServiceDidFetchComments(comments: comments)
        }
    }

    // MARK: - CREATE

    // MARK: - UPDATE

    // MARK: - DELETE

    // MARK: - AUTH

    // ...

}

// MARK: - WebServiceConfiguration

private let baseURL = "https://api.vid.me"

func configureURL(endpoint: String) -> String {
    let url = baseURL + endpoint
    return url
}

// Endpoints

enum VideoSort: String {
    case featured = "/videos/featured"
    case following = "/videos/following"
    case hot = "/videos/hot"
    case liked = "/videos/liked"
    case list = "/videos/list"
    case new = "/videos/new"
    case trending = "/videos/trending"
}

enum CommentSort: String {
    case list = "/comments/list"
}

// Params

let clientID = ""
let clientSecret = ""
let grantType = ""

let headers = ["Authorization" : ""]
let parammeters = ["PLATFORM" : "ios"]





















