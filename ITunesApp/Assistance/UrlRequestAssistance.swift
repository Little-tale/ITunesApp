//
//  UrlRequestAssistance.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift


class UrlRequestAssistance {
    
    static let shared = UrlRequestAssistance()
    private init() {}
    
    func requestAF<T: Decodable>(type: T.Type, router: ITunesRouter) -> Observable<T> {
        
        let afObservable = Observable<T>.create { observable in

            AF.request(router)
                .responseDecodable(of: type) { response in
                    switch response.result {
                    case .success(let data):
                        print("success")
                        
                        observable.onNext(data)
                        observable.onCompleted()
                        
                    case .failure(let error):
                        print(error)
                        observable.onError(error)
                    }
                }
            return Disposables.create()
        }
        
        return afObservable
    }
    
}
