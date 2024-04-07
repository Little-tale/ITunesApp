//
//  layoutExtenion.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit

// Recent
extension SearchControllerViewController {
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
