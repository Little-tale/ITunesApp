//
//  DownloadAppViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa


class DownloadAppViewModel: ViewModelType {
    
    var disposeBag: RxSwift.DisposeBag = .init()
    
    let realmRepo = RealmManager()
    
    struct Input {
        let viewWillAppear: ControlEvent<Bool>
    }
    
    struct Output {
        let outApps: BehaviorRelay<[DownloadApp]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let model = BehaviorRelay<[DownloadApp]> (value: [])
        
        input.viewWillAppear
            .filter({ $0 == true })
            .distinctUntilChanged()
            .bind(with: self) { owner, _ in
                owner.realmRepo.readModel(DownloadApp.self)
                    .subscribe { apps in
                        model.accept(apps)
                    } onError: { error in
                        print(error)
                    }
                    .disposed(by: owner.disposeBag)
            }.disposed(by: disposeBag)
        
        return Output(outApps: model)
    }
}
