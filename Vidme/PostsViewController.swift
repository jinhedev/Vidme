//
//  ViewController.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit
import RealmSwift

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WebServiceDelegate, PersistentContainerDelegate {

    // MARK: - API

    var posts: Results<Post>? {
        didSet {
            self.tableViewReload()
            self.refreshControl.endRefreshing()
        }
    }

    var refreshControl: UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!

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

    func handleRefresh() {
        self.tableView.reloadData()
        webServiceManager?.fetchPosts(type: VideoSort.hot)
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

    func webServiceDidFetchPosts(posts: [NSDictionary]) {
        var realmPosts = [Post]()
        for post in posts {
            guard let video_id = post["video_id"] as? String, let thumbnail_url = post["thumbnail_url"] as? String, let title = post["title"] as? String, let postDescription = post["description"] as? String, let created_at = post["date_created"] as? String, let updated_at = post["date_stored"] as? String, let upvotes = post["likes_count"] as? Int else {
                return
            }
            let realmPost = Post()
            realmPost.id = video_id
            realmPost.postImagePath = thumbnail_url
            realmPost.title = title
            realmPost.postDescription = postDescription
            realmPost.created_at = created_at.toSystemDate()
            realmPost.updated_at = updated_at.toSystemDate()
            realmPost.upvotes = upvotes
            realmPosts.append(realmPost)
        }
        realmManager?.updateObjects(objects: realmPosts)
    }

    // MARK: - PersistentContainerDelegate

    var realmManager: RealmManager?

    private func setupPersistentContainerDelegate() {
        realmManager = RealmManager()
        realmManager!.delegate = self
    }

    func containerDidErr(error: Error) {
        promptAlert(title: "Error", message: error.localizedDescription)
    }

    func containerDidFetchPosts(posts: Results<Post>?) {
        if posts != nil {
            self.posts = posts!
        }
    }

    func containerDidUpdateObjects() {
        realmManager?.fetchPosts(sortedKeyPath: "upvotes", ascending: false)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupWebServiceDelegate()
        setupPersistentContainerDelegate()

        // comment the code below out in stagging or prod
        print(realmManager!.pathForContainer())

        webServiceManager?.fetchPosts(type: VideoSort.hot)
        self.refreshControl.beginRefreshing()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postViewController = segue.destination as? PostViewController {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow, let selectedPost = posts?[selectedIndexPath.row] else {
                print(trace(file: #file, function: #function, line: #line))
                return
            }
            postViewController.selectedPost = selectedPost
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TileCell.id, for: indexPath) as? TileCell else {
            return UITableViewCell()
        }
        cell.configureCell(post: posts?[indexPath.row])
        return cell
    }

}

// Ugly error handler

extension PostsViewController {

    func promptAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

























