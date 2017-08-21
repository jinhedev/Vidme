//
//  DetailCell.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    var comment: Comment? {
        didSet {
            updateCell()
        }
    }

    static let id = String(describing: CommentCell.self)

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    private func updateCell() {
        // STEP 1: reset any existing UI info/outlets, otherwise info could become misplaced
        userLabel?.text = nil
        dateLabel?.text = nil
        commentLabel?.text = nil
        // STEP 2: load new info from user (if any)
        
    }

    private func setupViews() {
        self.backgroundColor = UIColor.darkGray
        self.userLabel.text = "username"
        self.dateLabel.text = "date"
        self.commentLabel.text = "comment"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

}
