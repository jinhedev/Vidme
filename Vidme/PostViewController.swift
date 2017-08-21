//
//  DetailsViewController.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit
import RealmSwift

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PersistentContainerDelegate {

    // MARK: - API

    var selectedPost: Post? {
        didSet {
            self.tableViewReload()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postImageView: UIImageView!

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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPersistentContainerDelegate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        return selectedPost?.comments.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.id, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        cell.configureCell(comment: selectedPost?.comments[indexPath.row])
        return cell
    }
    
}


