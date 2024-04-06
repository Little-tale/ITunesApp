//
//  SearchTableCellViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchTableCellViewModel: ViewModelType {
    
    let disposeBag: DisposeBag = .init()
    
    struct Input {
        let inputModel: BehaviorRelay<SearchResult>
        let inputDownButtonTap : ControlEvent<Void>
    }
    
    struct Output {
        let trackName: Driver<String>
        let sellerName: Driver<String>
        let artworkUrl60: Driver<URL?>
        let averageUserRating: Driver<String>
        let genres: Driver<String>
        
        let screenShots: Driver<[URL?]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let trackName = input.inputModel
            .map { $0.trackName }
            .asDriver(onErrorJustReturn: "")
        
        let sellerName = input.inputModel
            .map { $0.sellerName }
            .asDriver(onErrorJustReturn: "")
        
        let artworkUrl60 = input.inputModel
            .map { $0.artworkUrl60 }
            .compactMap { URL(string: $0) }
            .asDriver(onErrorJustReturn: nil)
        
        let averageUserRating = input.inputModel
            .map { $0.averageUserRating }
            .map { $0.rounded2 }
            .asDriver(onErrorJustReturn: "")
        
        let genre = input.inputModel
            .compactMap { $0.genres.first }
            .asDriver(onErrorJustReturn: "")
        
        let screenShots = input.inputModel
            .map { $0.screenshotUrls }
            .map { $0.prefix(3) }
            .compactMap { $0.map { URL(string: $0) } }
            .asDriver(onErrorJustReturn: [nil])
        
       
        return Output(
            trackName: trackName,
            sellerName: sellerName,
            artworkUrl60: artworkUrl60,
            averageUserRating: averageUserRating,
            genres: genre,
            screenShots: screenShots
        )
    }
    
    
    
}



/*
 오늘 회고록
 
 Thread 1: Assertion failed: This is a feature to warn you that there is already a delegate (or data source) set somewhere previously. The action you are trying to perform will clear that delegate (data source) and that means that some of your features that depend on that delegate (data source) being set will likely stop working.
 If you are ok with this, try to set delegate (data source) to `nil` in front of this operation.
  This is the source object value: <UITableView: 0x104018e00; frame = (0 105.667; 393 712.333);
 
 
 */
