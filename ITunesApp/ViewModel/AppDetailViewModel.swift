//
//  appDetailViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class AppDetailViewModel: ViewModelType {
    
    let disposeBag: RxSwift.DisposeBag = .init()
    
    struct Input {
        let inputModel : BehaviorSubject<SearchResult>
    }
    
    struct Output {
        let outputAppInfo: BehaviorRelay<AppInfoModel>
        
    }
    
    func transform(_ input: Input) -> Output {
        
        let outputRelay = BehaviorRelay<AppInfoModel> (value: AppInfoModel.init(appImageUrl: "", appTrackName: "", appCompanyName: ""))
        
        input.inputModel
            .map { result -> AppInfoModel in
                return AppInfoModel(
                    appImageUrl: result.artworkUrl100,
                    appTrackName: result.trackName,
                    appCompanyName: result.sellerName)
            }
            .bind(to: outputRelay)
            .disposed(by: disposeBag)

        return Output(outputAppInfo: outputRelay)
    }
    
}

