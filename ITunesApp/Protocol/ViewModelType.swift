//
//  ViewMocelType.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import RxSwift


protocol ViewModelType {
    
    var disposeBag: DisposeBag { get }
    
    associatedtype Input
    
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
