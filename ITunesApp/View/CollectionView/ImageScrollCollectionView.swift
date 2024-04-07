//
//  ImageScrollCollectionView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit
import RxSwift
import Kingfisher
import RxCocoa

struct ImageCellModel {
    let imageUrlString: [String]
}

final class ImageScrollCollectionView: UICollectionView {
    
    let viewModel = ImageCollecionViewModel()
    
    let disposeBag = DisposeBag()
    
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: ImageScrollCollectionView.setupLayout())
        
        register(OnlyImageCell.self, forCellWithReuseIdentifier: OnlyImageCell.identifier)
    }
    
    func setModel(_ model: BehaviorRelay<ImageCellModel>) {
        let input = ImageCollecionViewModel.Input(inputModel: model)
        
        let output = viewModel.transform(input)
        
        output
            .outUrls
            .drive(rx.items(
                cellIdentifier: OnlyImageCell.identifier,
                cellType: OnlyImageCell.self)
            ) { row, value, cell in
                print(value)
            cell.imageView.kf.setImage(with: value)
        }
        .disposed(by: disposeBag)
    }
    
    private
    static func  setupLayout() -> UICollectionViewFlowLayout{
        let layout = AutoPaginCollectionFlowLayout()
        
        if let size = UIScreen.current?.bounds.size {
            layout.itemSize = CGSize(width: size.width - 100, height: 400)
        } else {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 100 , height: 240)
        }
        layout.scrollDirection = .horizontal
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


