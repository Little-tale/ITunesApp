//
//  NewNewsCell.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class NewNewsCell: UICollectionViewCell, LayoutProtocol {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(versionLabel)
        contentView.addSubview(detailLabel)
    }
    
    func configureLayout() {
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
    
    func designView() {
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit: NewNewsCell")
    }
    
}
