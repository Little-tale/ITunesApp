//
//  MovieCollectionViewCell.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit
import SnapKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(label)
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
