//
//  AppDetailView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class AppDetailView: BaseView {
    

    let scrollView = UIScrollView(frame: .zero).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    let appinfo = AppInfoView(frame: .zero)
    let detailView = AppDetailVersionView(frame: .zero)
    let imageScrollView = ImageScrollCollectionView(frame: .zero)
    let detailIntroduceView = AppIntroduceView()

    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(appinfo)
        scrollView.addSubview(detailView)
        scrollView.addSubview(imageScrollView)
        scrollView.addSubview(detailIntroduceView)
    }
    

    override func designView() {
        
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        appinfo.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(scrollView.contentLayoutGuide)
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(140)
        }
        detailView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(appinfo)
            make.top.equalTo(appinfo.snp.bottom)
        }
        imageScrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(detailView)
            make.top.equalTo(detailView.snp.bottom)
            make.height.equalTo(400)
        }
        detailIntroduceView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(appinfo)
            make.top.equalTo(imageScrollView.snp.bottom).offset(10)
            make.bottom.equalTo(scrollView)
        }
    }
    
    
    
}


/* 컬렉션뷰는 다음에 하는걸로 해야할듯 핵심은 이게 아니였어서
 
 typealias DataSource = UICollectionViewDiffableDataSource<AppDetailSection,SearchResult>
 
  var dataSource: DataSource?
 
 enum AppDetailSection:Int, CaseIterable {
     case NewNews
     case Images
     case detailAppInfo
 }
 
 
 let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
 
 scrollView.addSubview(collectionView)
 
 collectionView.snp.makeConstraints { make in
     make.top.equalTo(appinfo.snp.bottom)
     make.width.horizontalEdges.equalTo(appinfo)
 }
 
 collectionView.setCollectionViewLayout(createCollectionLayout(), animated: true)
 
 override func register() {
     collectionView.register(NewNewsCell.self, forCellWithReuseIdentifier: NewNewsCell.identifier)
 }
 
 private func createCollectionLayout() -> UICollectionViewLayout {
     return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
         
         guard let sectionType = AppDetailSection(rawValue: sectionIndex) else {
             print("createCollectionLayout Error")
             return nil
         }
         
         return sectionType.createSectionLayout(environment: layoutEnvironment)
         
     }
 }
 
 
 func settingModel(_ model: SearchResult) {
     var snapShot = NSDiffableDataSourceSnapshot<AppDetailSection, SearchResult> ()
     
     let section = AppDetailSection.allCases
     
     let items = model
     snapShot.appendSections(section)
     snapShot.appendItems([model], toSection: .NewNews)
     print("settingModel")
     dataSource?.apply(snapShot)
 }
 
 private func setSnapShot(){
   
 
 setDataSource()
 }
 
 */
