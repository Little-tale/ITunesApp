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
    
    let userDefaults = UserDefaultsAssistance()
    
    struct Input {
        let searchText: PublishSubject<String>
        let recentSelected: PublishSubject<RecentModel>
    }
    struct Output {
        let resultData: BehaviorRelay<[SearchResult]>
        let recenData: BehaviorRelay<[RecentModel]>
    }
    
    func transform(_ input: Input) -> Output {
        let behiber = BehaviorRelay<[SearchResult]> (value: [])
        let recent = BehaviorRelay<[RecentModel]> (value: [])
        
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
            .share(replay: 2)
            .bind(to: behiber)
            .disposed(by: disposeBag)
        
        input.searchText
            .filter { $0 != "" }
            .bind(with: self) { owner, string in
                let recentModel = RecentModel(appName: string, primery: string)

                let re = owner.userDefaults.saveList(data: recentModel, forkey: .recent)
                re.bind(to: recent)
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        input.recentSelected
            .map { $0.appName }
            .bind(to: input.searchText)
            .disposed(by: disposeBag)
        
        userDefaults.loadList(data: RecentModel.self, forkey: .recent)
            .subscribe(onNext: { models in
                recent.accept(models)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        
        
        return Output(
            resultData: behiber,
            recenData: recent
        )
    }
}



