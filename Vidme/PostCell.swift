//
//  MasterCell.swift
//  Vidme
//
//  Created by rightmeow on 8/21/17.
//  Copyright © 2017 Duckensburg. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class PostCell: UITableViewCell {

    static let id = String(describing: PostCell.self)

    // MARK: - API

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!

    func configureCell(post: Post?) {
        if let post = post {
            titleLabel.text = post.title
            postDescriptionLabel.text = post.postDescription
            votesLabel.text = String(describing: post.upvotes) + " Likes"

            if !post.embeded_url.isEmpty {
                fetchVideo(from: post.postVideoPath, completion: {
                    self.play()
                })
            } else {
                print("something is wrong")
            }
        }
    }

    private func setupCell() {
        self.backgroundColor = Color.midNightBlack
        self.titleLabel.text = ""
        self.postDescriptionLabel.text = ""
    }

    // MARK: - VideoView

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var videoView: UIView!

    var avPlayer: AVPlayer?

    var isPlaying: Bool = false

    func fetchVideo(from path: String, completion: () -> Void) {
        activityIndicator.startAnimating()
        let url = URL(fileURLWithPath: path)
        avPlayer = AVPlayer(url: url)
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        self.videoView.layer.addSublayer(avPlayerLayer)
        avPlayerLayer.frame = self.videoView.frame
        completion()
    }

    func play() {
        avPlayer?.play()
        isPlaying = true
        activityIndicator.stopAnimating()
    }

    func pause() {
        avPlayer?.pause()
        isPlaying = false
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

}






























