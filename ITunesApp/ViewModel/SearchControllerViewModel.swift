//
//  SearchControllerViewModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa


class SearchControllerViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchConText: ControlProperty<String?>
        let searchConTap: ControlEvent<Void>
    }
    
    struct Output {
        let searchText: Observable<String>
    }
    
    func transform(_ input: Input) -> Output {
        
        let searchDriver = input.searchConTap
            .withLatestFrom(input.searchConText.orEmpty)
            //.asDriver(onErrorJustReturn: "")
        
        return .init(searchText: searchDriver)
    }
    
}
