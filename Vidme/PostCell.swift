//
//  MasterCell.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {

    static let id = String(describing: PostCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var votesLabel: UILabel!

    func configureCell(post: Post?) {
        if let post = post {
            titleLabel.text = post.title
            votesLabel.text = String(describing: post.upvotes) + " Likes"
            // download the image and cache it
            let imageCache = AutoPurgingImageCache(memoryCapacity: 100_000_000, preferredMemoryUsageAfterPurge: 60_000_000)
            if let cachedImage = imageCache.image(withIdentifier: post.postImagePath) {
                DispatchQueue.main.async {
                    self.postImageView.image = cachedImage
                    return
                }
            } else {
                Alamofire.request(post.postImagePath, method: .get).responseImage(completionHandler: { response in
                    self.postImageView.image = nil
                    DispatchQueue.main.async {
                        guard let image = response.result.value else {
                            print("failed to parse image from response")
                            return
                        }
                        self.postImageView.af_setImage(withURL: URL(string: post.postImagePath)!, placeholderImage: #imageLiteral(resourceName: "sample"))
                        imageCache.add(image, withIdentifier: post.postImagePath)
                        self.postImageView.image = image
                    }
                })
            }
        }
    }

    private func setupCell() {
        self.backgroundColor = UIColor.darkGray
        self.titleLabel.text = "title"
        self.postImageView.image = #imageLiteral(resourceName: "sample")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

}































