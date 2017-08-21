//
//  DetailsViewController.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    // MARK: - API

    var comments: [Comment]?
    
}

extension PostViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}

extension PostViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.id, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}
