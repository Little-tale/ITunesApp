//
//  ImageCollecionViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa

class ImageCollecionViewModel: ViewModelType {
    
    var disposeBag: RxSwift.DisposeBag = .init()
    
    struct Input {
        let inputModel: BehaviorRelay<ImageCellModel>
    }
    
    struct Output {
        let outUrls: Driver<[URL]>
    }
    
    func transform(_ input: Input) -> Output {
        let imageDriver = input.inputModel
            .compactMap{ $0.imageUrlString.compactMap{ URL(string:$0) } }
            .asDriver(onErrorJustReturn: [])
        
        return Output(outUrls: imageDriver)
    }
    
}
