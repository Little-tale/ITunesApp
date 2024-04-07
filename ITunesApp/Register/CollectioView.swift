//
//  CollectioView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit


//
//extension AppDetailView {
//    
//    func setDataSource(){
//        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            
//            guard let sectionType = AppDetailSection(rawValue: indexPath.section) else { return .init()}
//            
//            
//            switch sectionType {
//            case .NewNews:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewNewsCell.identifier, for: indexPath) as? NewNewsCell
//                else { print("Cell Error"); return .init()}
//                
//                cell.versionLabel.text = itemIdentifier.version
//                cell.detailLabel.text = itemIdentifier.description
//                return cell
//            case .Images:
//                break
//            case .detailAppInfo:
//                break
//            }
//            return .init()
//        })
//    }
//}
//
