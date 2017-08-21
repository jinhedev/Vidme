//
//  MasterCell.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    var post: Post? {
        didSet {
            updateCell()
        }
    }

    static let id = String(describing: PostCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!

    private func updateCell() {
        // STEP 1: reset any existing UI info/outlets, otherwise info could become misplaced
        titleLabel?.text = nil
        postImageView?.image = nil
        // STEP 2: load new info from user (if any)
        
    }

    private func setupViews() {
        self.backgroundColor = UIColor.darkGray
        self.titleLabel.text = "title"
        self.postImageView.image = #imageLiteral(resourceName: "sample")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

}
