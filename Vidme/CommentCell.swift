//
//  DetailCell.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    static let id = String(describing: CommentCell.self)

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    func configureCell(comment: Comment?) {
        if let comment = comment {
            userLabel.text = comment.username
            dateLabel.text = comment.created_at.toRelativeDate()
            commentLabel.text = comment.text
        }
    }

    private func setupCell() {
        self.backgroundColor = Color.black
        self.userLabel.text = ""
        self.dateLabel.text = ""
        self.commentLabel.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

}
