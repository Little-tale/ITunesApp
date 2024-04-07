//
//  AppIntroduceView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

struct AppIntroduceModel {
    let description : String
}

class AppIntroduceView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.text = "자세한 정보"
    }
    
    let introLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .thin)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private let subject = PublishSubject<AppIntroduceModel> ()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(introLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
        }
        introLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    func setModel(_ model: BehaviorRelay<AppIntroduceModel>) {
        model.bind(to: subject)
            .disposed(by: rxDisPoseBag)
//        subject.onNext(model)
    }
    
    
    override func subscribe() {
        subject
            .map { $0.description }
            .subscribe(with: self) {
                owner, data in
                owner.introLabel.text = data
            }.disposed(by: rxDisPoseBag)
    }
}
