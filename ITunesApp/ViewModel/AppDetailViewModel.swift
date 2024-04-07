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
        let outAppDetailInfo: BehaviorRelay<AppDetailModel>
        let outImages: BehaviorRelay<ImageCellModel>
        let outIntroduce: BehaviorRelay<AppIntroduceModel>
    }
    
    
    func transform(_ input: Input) -> Output {
        
        let outputRelay = BehaviorRelay<AppInfoModel> (value: AppInfoModel.init(appImageUrl: "", appTrackName: "", appCompanyName: ""))
        
        let outAppDetailInfo = BehaviorRelay<AppDetailModel> (value: .init(detailLabelText: "",version: ""))
        
        let imageModel = BehaviorRelay<ImageCellModel>(value: .init(imageUrlString: []))
        
        let introduce = BehaviorRelay<AppIntroduceModel>(value: .init(description: ""))
        
        input.inputModel
            .map { result -> AppInfoModel in
                return AppInfoModel(
                    appImageUrl: result.artworkUrl100,
                    appTrackName: result.trackName,
                    appCompanyName: result.sellerName)
            }
            .bind(to: outputRelay)
            .disposed(by: disposeBag)
        
        input.inputModel
            .map({ result -> AppDetailModel in
                return AppDetailModel(
                    detailLabelText: result.releaseNotes ?? "",
                    version: result.version
                )
            })
            .bind(to: outAppDetailInfo)
            .disposed(by: disposeBag)
        
        input.inputModel
            .map { $0.screenshotUrls.prefix(5) }
            .map { array -> ImageCellModel in
                return ImageCellModel(
                    imageUrlString: Array(array)
                )
            }
            .bind(to: imageModel)
            .disposed(by: disposeBag)
        
        input.inputModel
            .map { $0.description }
            .map { string -> AppIntroduceModel in
                return AppIntroduceModel(description: string)
            }
            .bind(to: introduce)
            .disposed(by: disposeBag)
        

        return Output(
            outputAppInfo: outputRelay,
            outAppDetailInfo: outAppDetailInfo,
            outImages: imageModel,
            outIntroduce: introduce
        )
    }
    
}

