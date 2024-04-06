//
//  AppInfoViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

final class AppInfoViewModel: ViewModelType {
    
    var disposeBag: RxSwift.DisposeBag = .init()
    
    
    struct Input {
        let inModel: BehaviorRelay<AppInfoModel>
    }
    
    struct Output{
        let appImageURL: Driver<URL?>
        let appTrackName: Driver<String>
        let appCompanyName: Driver<String>
    }
    
    func transform(_ input: Input) -> Output {
        
        let appImageDriver = input.inModel
            .map { $0.appImageUrl }
            .asDriver(onErrorJustReturn: nil)
        
        let appTrackName = input.inModel
            .map { $0.appTrackName }
            .asDriver(onErrorJustReturn: "")
        
        let appCompany = input.inModel
            .map { $0.appCompanyName }
            .asDriver(onErrorJustReturn: "")
        
        
        return Output(
            appImageURL: appImageDriver,
            appTrackName: appTrackName,
            appCompanyName: appCompany
        )
    }
    
}
