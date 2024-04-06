//
//  SearchAppInfoTableCell.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Kingfisher

class SearchAppInfoTableCell: UITableViewCell {

    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var disposeBag = DisposeBag()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemMint
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let dummyStarImageView = UIImageView().then {
        $0.image = .init(systemName: "star.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .blue
    }
    
    let userScoreLable = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .systemGray
    }
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    let companyNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .systemGray
        $0.textAlignment = .center
    }
    
    let genreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .systemGray
        $0.textAlignment = .center
    }
    
    let appInfoImage1 = UIImageView()
    let appInfoImage2 = UIImageView()
    let appInfoImage3 = UIImageView()
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        // $0.alignment = .fill
        $0.spacing = 10
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.distribution = .fillEqually
    }
     
    private lazy var imageArray = [appInfoImage1, appInfoImage2, appInfoImage3]
    
    let viewModel = SearchTableCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appIconImageView)
        contentView.addSubview(downloadButton)
        contentView.addSubview(dummyStarImageView)
        contentView.addSubview(userScoreLable)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(stackView)
        
        
        
        imageArray.forEach { [weak self] image in
            guard let self else { return }
            self.stackView.addArrangedSubview(image)
        }
        
        appIconImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
    
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        dummyStarImageView.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView)
            make.top.equalTo(appIconImageView.snp.bottom).offset(12)
        }
        
        userScoreLable.snp.makeConstraints { make in
            make.leading.equalTo(dummyStarImageView.snp.trailing).offset(4)
            //make.top.equalTo(companyNameLabel)
            make.centerY.equalTo(companyNameLabel)
            make.width.equalTo(40)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.top.equalTo(appIconImageView.snp.bottom).offset(13)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.trailing.equalTo(downloadButton)
            make.centerY.equalTo(companyNameLabel)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(dummyStarImageView.snp.bottom).offset(8)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().inset(12)
        }
        
        imageArray.forEach {
            $0.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
            }
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 0.2
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.isHidden = true
        }
    }
    
    func settingModel(_ model: SearchResult) {
        let behiberModel = BehaviorRelay(value: model)
        
        let input = SearchTableCellViewModel
            .Input(
                inputModel: behiberModel,
                inputDownButtonTap: downloadButton.rx.tap
            )
        let output = viewModel.transform(input)
        
        output
            .artworkUrl60
            .asObservable()
            .withUnretained(self)
            .bind { owner, url in
                owner.appIconImageView.kf.setImage(with: url)
            }.disposed(by: disposeBag)
        
        output
            .averageUserRating
            .drive(userScoreLable.rx.text)
            .disposed(by: disposeBag)
        
        output
            .genres
            .drive(genreLabel.rx.text)
            .disposed(by: disposeBag)
        
        output
            .sellerName
            .drive(companyNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.trackName
            .drive(appNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 이미지가 없을 경우도 있드라 수정
        output.screenShots
            .asObservable()
            .withUnretained(self)
            .subscribe { owner, url in
                for (index, value) in url.enumerated() {
                    let imageview = owner.imageArray[index]
                    imageview.isHidden = false
                    imageview.kf.setImage(with: value)
                    imageview.kf.setImage(with: value, options: [
                        .transition(.fade(0.5)),
                        .processor(DownsamplingImageProcessor(size: .init(width: 130, height: 200))),
                        .scaleFactor(UIScreen.current?.scale ?? 300)
                    ])
                }
            
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageArray.forEach { view in
            view.isHidden = true
        }
        disposeBag = DisposeBag()
        viewModel.disposeBag = .init()
    }
}
