//
//  DownLoadAppTableViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa

class DownLoadAppTableViewModel: ViewModelType {
    
    var disposeBag: RxSwift.DisposeBag = .init()
    
    struct Input {
        let inputModel: PublishRelay<DownloadApp>
    }
    
    struct Output {
        let appNameLabel : Driver<String>
        let appIconImageView : Driver<URL?>
    }
    
    
    func transform(_ input: Input) -> Output {
        
        let appNameLabel = input.inputModel
            .map { $0.appName }
            .asDriver(onErrorJustReturn: "")
        
        
        let appIconImageView = input.inputModel
            .map { $0.appImage }
            .compactMap { URL(string:$0) }
            .asDriver(onErrorJustReturn: nil)
        
        return Output(
            appNameLabel: appNameLabel,
            appIconImageView: appIconImageView
        )
        
    }
}
