//
//  SearchResultsViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchResultsViewModel: ViewModelType {
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchText: Observable<String>
    }
    struct Output {
        let resultData: BehaviorRelay<[SearchResult]>
    }
    
    func transform(_ input: Input) -> Output {
        let behiber = BehaviorRelay<[SearchResult]> (value: [])
        
        input.searchText
            .distinctUntilChanged()
            .debounce(.milliseconds(600), scheduler: MainScheduler.instance)
            .flatMapLatest { searchText in
                guard !searchText.isEmpty else {
                    print("no no no title ")
                    return Observable.just(ITunes(results: []))
                }
                return UrlRequestAssistance.shared.requestAF(type: ITunes.self, router: .search(term: searchText))
            }
            .map({ $0.results })
            .bind(to: behiber)
            .disposed(by: disposeBag)
        
        return Output(resultData: behiber)
    }
}



