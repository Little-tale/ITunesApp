//
//  AppDeatilInfo.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa

class AppDeatilInfoViewModel: ViewModelType{
    
    
    var disposeBag: RxSwift.DisposeBag = .init()
    
    
    struct Input {
        let inModel: BehaviorRelay<AppDetailModel>
    }
    
    struct Output {
        let detailTextDriver: Driver<String>
        let versionTextDriver: Driver<String>
    }
    
    
    func transform(_ input: Input) -> Output {
        let detailDriver = input.inModel
            .map({ $0.detailLabelText })
            .asDriver(onErrorJustReturn: "none.")
        
        let versionTextDriver = input.inModel
            .map { "버전 :" + $0.version }
            .asDriver(onErrorJustReturn: "버전 :")
        
        
        return Output(
            detailTextDriver: detailDriver,
            versionTextDriver: versionTextDriver
        )
    }
}
