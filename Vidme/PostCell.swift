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
                requestVideo(path: post.embeded_url)
            } else if !post.youtube_override_source.isEmpty {
                requestVideo(path: post.youtube_override_source)
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

    @IBOutlet weak var webView: UIWebView! // just testing
    @IBOutlet weak var videoView: UIView!

    var avPlayer: AVPlayer?

    var isPlaying: Bool = false

    func fetchVideo(from path: String, completion: () -> Void) {
        let url = URL(fileURLWithPath: path)
        avPlayer = AVPlayer(url: url)
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        self.videoView.layer.addSublayer(avPlayerLayer)
        avPlayerLayer.frame = self.videoView.frame
        completion()
    }

    func requestVideo(path: String) {
        let url = URL(fileURLWithPath: "https://www.youtube.com/watch?v=594qtjmhOFE")
        let request = URLRequest(url: url)
        DispatchQueue.main.async {
            self.webView.loadRequest(request)
        }
    }

    func play() {
        avPlayer?.play()
        isPlaying = true
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

extension PostCell: UIWebViewDelegate {

    func webViewDidStartLoad(_ webView: UIWebView) {
        print(111)
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(000)
    }

}































