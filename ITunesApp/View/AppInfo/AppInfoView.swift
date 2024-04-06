//
//  AppInfoView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

struct AppInfoModel {
    let appImageUrl: URL?
    let appTrackName: String
    let appCompanyName: String
    
    init(appImageUrl: String, appTrackName: String, appCompanyName: String, downButton: String) {
        self.appImageUrl = URL(string: appImageUrl)
        self.appTrackName = appTrackName
        self.appCompanyName = appCompanyName
    }
}

class AppInfoView: BaseView{
    
    let appImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.3
        $0.clipsToBounds = true
    }
    
    let apptrackName = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let appCompanyName = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    let downButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 16
    }
    
    
    override func configureHierarchy() {
        addSubview(appImageView)
        addSubview(apptrackName)
        addSubview(appCompanyName)
        addSubview(downButton)
    }
    
    override func configureLayout() {
        appImageView.snp.makeConstraints { make in
            make.size.equalTo(140)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        apptrackName.snp.makeConstraints { make in
            make.leading.equalTo(appImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
            make.top.equalTo(appImageView).offset(8)
        }
        appCompanyName.snp.makeConstraints { make in
            make.centerY.equalTo(appImageView)
            make.leading.equalTo(apptrackName)
        }
        downButton.snp.makeConstraints { make in
            make.leading.equalTo(apptrackName)
            make.height.equalTo(32)
            make.width.equalTo(72)
            make.bottom.equalTo(appImageView)
        }
    }
    
    func setUI(_ model: AppInfoModel){
        appImageView.kf.setImage(with: model.appImageUrl)
        apptrackName.text = model.appTrackName
        appCompanyName.text = model.appCompanyName
    }
    
}
