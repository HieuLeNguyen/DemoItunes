//
//  DetailViewController.swift
//  DemoItunes
//
//  Created by Nguyễn Văn Hiếu on 14/11/24.
//

import UIKit
import AVKit
import AVFoundation

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var primaryLabel: UILabel!
    
    // MARK: - Variables
    static let identifier = "DetailViewController"
    var urlVideo: String?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapWatchButton(_ sender: Any) {
        playVideo(with: urlVideo)
    }
    
    func playVideo(with url: String?) {
        guard let urlVideo = url,
        let videoURL = URL(string: urlVideo)
        else {
            print("Invalid video URL")
            return
        }

        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player
        
        present(vc, animated: true) {
            player.play()
        }
    }
    
    //    chỉ sử dụng để tạo file với tệp .xib không phải trong main.storyboard
    //    static func nib() -> UINib {
    //        return UINib(nibName: "DetailViewController", bundle: nil)
    //    }
    
}
