//
//  MyCollectionViewCell.swift
//  DemoItunes
//
//  Created by Nguyễn Văn Hiếu on 13/11/24.
//

import UIKit
import Kingfisher

class MyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Variables
    static let identifier = "MyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: URL, _ title: String) {
        titleLabel.text = title
        imageView.kf.setImage(with: image)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }


}
