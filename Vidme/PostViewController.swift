//
//  DetailsViewController.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import AlamofireImage
import AVFoundation
import AVKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WebServiceDelegate, PersistentContainerDelegate {

    // MARK: - API

    var selectedPost: Post?

    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    let playerController = AVPlayerViewController()

    var comments: Results<Comment>? {
        didSet {
            self.tableViewReload()
            self.refreshControl.endRefreshing()
        }
    }

    @IBAction func handlePlay(_ sender: UITapGestureRecognizer) {
        guard let path = selectedPost?.postVideoPath else { return }
        let url = URL(fileURLWithPath: path)
        self.player = AVPlayer(url: url)
        self.playerController.player = self.player

        playerLayer = AVPlayerLayer(player: player)


        self.present(self.playerController, animated: true) { 
            self.playerController.player?.play()
        }
    }

    // MARK: - UITableView

    @IBOutlet weak var tableView: UITableView!

    var refreshControl: UIRefreshControl!

    func handleRefresh() {
        self.tableView.reloadData()
    }

    private func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func setupTableView() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = self.refreshControl
    }

    // MARK: - WebServiceDelegate

    var webServiceManager: WebServiceManager?

    private func setupWebServiceDelegate() {
        webServiceManager = WebServiceManager()
        webServiceManager!.delegate = self
    }

    func webServiceDidErr(error: Error) {
        promptAlert(title: "Error", message: error.localizedDescription)
    }

    // ugly
    func webServiceDidFetchComments(comments: [NSDictionary]) {
        var realmComments = [Comment]()
        for comment in comments {
            guard let comment_id = comment["comment_id"] as? String, let user = comment["user"] as? [String : Any], let username = user["username"] as? String, let commentText = comment["body"] as? String, let created_at = comment["date_created"] as? String, let updated_at = comment["date_created"] as? String, let commentCount = comment["comment_count"] as? Int else {
                return
            }
            let realmComment = Comment()
            realmComment.id = comment_id
            realmComment.username = username
            realmComment.text = commentText
            realmComment.created_at = created_at.toSystemDate()
            realmComment.updated_at = updated_at.toSystemDate()
            realmComment.commentsCount = commentCount
            realmComments.append(realmComment)
        }
        realmManager?.updateObjects(objects: realmComments)
    }

    // MARK: - PersistentContainerDelegate

    var realmManager: RealmManager?

    private func setupPersistentContainerDelegate() {
        realmManager = RealmManager()
        realmManager!.delegate = self
    }

    func containerDidErr(error: Error) {
        print(trace(file: #file, function: #function, line: #line))
        promptAlert(title: "Error", message: error.localizedDescription)
    }

    func containerDidUpdateObjects() {
        realmManager?.fetchComments(sortedKeyPath: "commentsCount", ascending: false)
    }

    func containerDidFetchComments(comments: Results<Comment>?) {
        if comments != nil {
            self.comments = comments!
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupWebServiceDelegate()
        setupPersistentContainerDelegate()
        guard let post = selectedPost else { return }
        webServiceManager?.fetchComments(type: CommentSort.list, video_id: post.id)
        self.refreshControl.beginRefreshing()
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return comments?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Comments"
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as? PostCell else {
                return UITableViewCell()
            }
            postCell.configureCell(post: selectedPost)
            return postCell
        } else if indexPath.section == 1 {
            guard let commentCell = tableView.dequeueReusableCell(withIdentifier: CommentCell.id, for: indexPath) as? CommentCell else {
                return UITableViewCell()
            }
            commentCell.configureCell(comment: comments?[indexPath.row])
            return commentCell
        } else {
            return UITableViewCell()
        }
    }
    
}

// Ugly error handler

extension PostViewController {

    func promptAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

