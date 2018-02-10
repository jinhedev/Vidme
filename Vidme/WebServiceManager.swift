//
//  WebServices.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
            switch response.result {
            case .success:
                if let jsonValue = response.result.value as? [String : Any], let posts = jsonValue["videos"] as? [NSDictionary] {
                    self.delegate?.webServiceDidFetchPosts(posts: posts)
                }
            case .failure(let error):
                self.delegate?.webServiceDidErr(error: error)
            }
        }
    }

    func fetchComments(type: CommentSort, video_id: String) {
        let url = configureURL(endpoint: type.rawValue)
        var videoParam = parammeters
        videoParam["video"] = video_id
        Alamofire.request(url, method: HTTPMethod.get, parameters: videoParam, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                if let jsonValue = response.result.value as? [String : Any], let comments = jsonValue["comments"] as? [NSDictionary] {
                    self.delegate?.webServiceDidFetchComments(comments: comments)
                }
            case .failure(let error):
                self.delegate?.webServiceDidErr(error: error)
            }
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





















