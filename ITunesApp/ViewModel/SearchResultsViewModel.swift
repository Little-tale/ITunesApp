//
//  SearchResultsViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa



final class SearchResultsViewModel: ViewModelType {
    let disposeBag = DisposeBag()
    
    let userDefaults = UserDefaultsAssistance()
    
    struct Input {
        let searchText: PublishSubject<String>
        let recentSelected: PublishSubject<RecentModel>
    }
    struct Output {
        let resultData: BehaviorRelay<[SearchResult]>
        let recenData: BehaviorRelay<[RecentModel]>
        let errorCase: PublishRelay<AleartModel>
    }
    
    func transform(_ input: Input) -> Output {
        let behiber = BehaviorRelay<[SearchResult]> (value: [])
        let recent = BehaviorRelay<[RecentModel]> (value: [])
        let ifError = PublishRelay<AleartModel> ()
        
        // MARK: 네트워크 시작 할 옵저버블
        let networkStart = input.searchText
            .distinctUntilChanged()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .flatMapLatest {
                UrlRequestAssistance.shared.requestAF(type: ITunes.self, router: .search(term: $0))
            }
            .share()
        
        // MARK: Success
        networkStart.subscribe {  result in
            guard case .success(let value) = result else {
                return
            }
            behiber.accept(value.results)
        }
        .disposed(by: disposeBag)
        
        // MARK: ERROR
        networkStart.subscribe { result in
            guard case .failure(let error) = result else {
                return
            }
            ifError.accept(.error)
        }
        .disposed(by: disposeBag)
        
        // MARK: UserDefaults Save
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
            recenData: recent,
            errorCase: ifError
        )
    }
}



//        input.searchText
//            .distinctUntilChanged()
//            .debounce(.milliseconds(600), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
//            // .observe(on: con)
//            .flatMapLatest { searchText in
//                guard !searchText.isEmpty else {
//                    print("no no no title ")
//                    return Observable.just(ITunes(results: []))
//                }
//                return UrlRequestAssistance.shared
//                    .requestAF(type: ITunes.self, router: .search(term: searchText))
//                    .catch
//            }
//            .observe(on: MainScheduler.instance)
//            .map({ $0.results })
//            .share(replay: 2)
//            .bind(to: behiber)
//            .disposed(by: disposeBag)
