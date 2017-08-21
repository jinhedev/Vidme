//
//  ViewController.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit
import RealmSwift

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PersistentContainerDelegate {

    // MARK: - API

    var posts: Results<Post>? {
        didSet {
            self.tableViewReload()
        }
    }

    @IBOutlet weak var tableView: UITableView!

    private func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK - PersistentContainerDelegate

    var realmManager: RealmManager?

    private func setupPersistentContainerDelegate() {
        realmManager = RealmManager()
        realmManager!.delegate = self
    }

    func containerDidErr(error: Error) {
        print(error.localizedDescription)
        print(trace(file: #file, function: #function, line: #line))
    }

    func containerDidFetchPosts(posts: Results<Post>?) {
        if posts != nil {
            self.posts = posts!
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPersistentContainerDelegate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        realmManager?.fetchPosts()
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
        return 44
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.configureCell(post: posts?[indexPath.row])
        return cell
    }

}

























