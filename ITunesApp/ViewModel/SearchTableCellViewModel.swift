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
        let imageView: BehaviorSubject<URL?>
    }
    
    func transform(_ input: Input) -> Output {
        let imageData = BehaviorSubject<URL?> (value: nil)
        
        input.inputModel
            .bind(with: self) { owner, result in
                imageData.onNext(URL(string:result.artworkUrl100))
            }
            .disposed(by: disposeBag)
            
        return Output(
            imageView: imageData
        )
    }
    
    
    
}



/*
 오늘 회고록
 
 Thread 1: Assertion failed: This is a feature to warn you that there is already a delegate (or data source) set somewhere previously. The action you are trying to perform will clear that delegate (data source) and that means that some of your features that depend on that delegate (data source) being set will likely stop working.
 If you are ok with this, try to set delegate (data source) to `nil` in front of this operation.
  This is the source object value: <UITableView: 0x104018e00; frame = (0 105.667; 393 712.333);
 
 
 */
