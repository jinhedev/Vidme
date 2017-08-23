//
//  TileCell.swift
//  Vidme
//
//  Created by rightmeow on 8/22/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TileCell: UITableViewCell {

    static let id = String(describing: TileCell.self)

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
                    self.postImageView.fadeIn()
                    self.postImageView.image = cachedImage
                    return
                }
            } else {
                postImageView.image = nil
                Alamofire.request(post.postImagePath, method: .get).responseImage(completionHandler: { response in
                    DispatchQueue.main.async {
                        guard let image = response.result.value else {
                            print("failed to parse image from response")
                            return
                        }
                        self.postImageView.fadeIn()
                        self.postImageView.af_setImage(withURL: URL(string: post.postImagePath)!, placeholderImage: #imageLiteral(resourceName: "Image Placeholder"))
                        imageCache.add(image, withIdentifier: post.postImagePath)
                        self.postImageView.image = image
                    }
                })
            }
        }
    }

    private func setupCell() {
        self.backgroundColor = Color.midNightBlack
        self.titleLabel.text = ""
        self.postImageView.image = #imageLiteral(resourceName: "Image Placeholder")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted == true {
            self.backgroundColor = Color.lightBlue
            self.titleLabel.textColor = Color.black
            self.votesLabel.textColor = Color.black
            self.postImageView.alpha = 0.5
        } else {
            self.backgroundColor = Color.midNightBlack
            self.titleLabel.textColor = Color.white
            self.votesLabel.textColor = Color.lightGray
            self.postImageView.alpha = 1.0
        }
    }

}
