//
//  OnlyImageCell.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit
import Kingfisher

class OnlyImageCell: UICollectionViewCell {

    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func designView() {
        self.layer.cornerRadius = 14
        self.clipsToBounds = true
        self.backgroundColor = .black
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        // backgoundImage.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingImageMode(_ mode: ContentMode){
        self.imageView.contentMode = mode
    }
}
