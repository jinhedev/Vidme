//
//  MasterCell.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    static let id = String(describing: PostCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!

    func configureCell(post: Post?) {
        titleLabel?.text = nil
        postImageView?.image = nil

        if let post = post {
            titleLabel.text = post.title
            postImageView.image = #imageLiteral(resourceName: "sample")
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
