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
    
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(appinfo)
        
    }
   
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        appinfo.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(140)
        }
        
        
    }
    
    
    
}
