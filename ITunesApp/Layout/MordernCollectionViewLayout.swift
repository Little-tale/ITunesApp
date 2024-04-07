//
//  MordernCollectionViewLayout.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit

protocol LayoutType {
    func createSectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection

}


//extension AppDetailSection: LayoutType{
//    
//    func createSectionLayout(environment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//        switch self {
//        case .NewNews:
//            return createNewNewsSectionLayout(environment)
//        case .Images:
//            break
//        case .detailAppInfo:
//            break
//        }
//        return createNewNewsSectionLayout(environment)
//    }
//    
//    private func createNewNewsSectionLayout(_ env:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .fractionalHeight(1)
//        )
//        
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
//        
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//    
//        let section = NSCollectionLayoutSection(group: group)
//        
//        section.contentInsets = NSDirectionalEdgeInsets(
//            top: 10, leading: 10, bottom: 10, trailing: 10
//        )
//        
//        return section
//    }
//
//}
