//
//  AppDetailInfo.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

struct AppDetailModel {
    let detailLabelText: String
    let version: String
}

class AppDetailVersionView: BaseView {
    let titleLabel = UILabel().then {
        $0.text = "새로운 소식"
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    let versionLabel = UILabel().then {
        $0.text = "버전"
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .systemGray
    }
    
    let detailLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .black
    }
    
    
    let viewModel = AppDeatilInfoViewModel()
    
    
    func setModel(_ model: BehaviorRelay<AppDetailModel>) {
        //let inModel = BehaviorRelay(value: model)
        
        let input = AppDeatilInfoViewModel.Input(inModel: model)
        
        let output = viewModel.transform(input)
        
        output.detailTextDriver
            .drive(detailLabel.rx.text)
            .disposed(by: rxDisPoseBag)
        
        output.versionTextDriver
            .drive(versionLabel.rx.text)
            .disposed(by: rxDisPoseBag)
    
    }
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(versionLabel)
        addSubview(detailLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.equalToSuperview().offset(4)
        }
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(titleLabel)
        }
        detailLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(titleLabel)
            $0.top.equalTo(versionLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
}
