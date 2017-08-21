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

enum VideoSort: String {
    case featured = "/videos/featured"
    case following = "/videos/following"
    case hot = "/videos/hot"
    case liked = "/videos/liked"
    case list = "/videos/list"
    case new = "/videos/new"
    case trending = "/videos/trending"
}

class WebServices {

    class var shared: WebServices {
        struct Static {
            static let instance: WebServices = WebServices()
        }
        return Static.instance
    }

    let clientID = ""
    let clientSecret = ""
    let grantType = ""
    let platform = "ios"

    private let baseURL = "https://api.vid.me"

    func fetchVideos(type: VideoSort, completion: @escaping (UIImage) -> Void) -> Request {
        let url = baseURL + type.rawValue
        return Alamofire.request(url, method: HTTPMethod.get, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
    }

}
