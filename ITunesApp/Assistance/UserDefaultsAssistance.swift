//
//  File.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import Foundation
import RxSwift

protocol UserDefaultsAssiType{
    // C
    func saveOf<T:Codable & Equatable>(data: T, forKey key: type) -> Observable<T>
    
    func saveList<T:Codable & Equatable>(data: T, forkey Key: type) -> Observable<[T]>
    
    // R
    func loadOf<T:Codable & Equatable>(data: T.Type, forkey key: type) -> Observable<T>
    
    func loadList<T:Codable & Equatable>(data: T.Type, forkey Key: type) -> Observable<[T]>
    // U
    
    // D
    
}
enum type {
    case recent

    var key: String{
        switch self {
        case .recent:
            "recentList"
        }
    }
}

enum UserDefaultsError: Error {
    case canDecode
}


class UserDefaultsAssistance:UserDefaultsAssiType {
   
    
    
    let disposeBag = DisposeBag()
    
    
    @discardableResult
    func saveOf<T:Codable & Equatable>(data: T, forKey key: type) -> Observable<T>{

        return Observable
            .create { observable in
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(data) {
                UserDefaults
                    .standard
                    .setValue(encoded, forKey: key.key)
                observable.onNext(data)
                
            } else {
                observable.onError(UserDefaultsError.canDecode)
            }
                observable.onCompleted()
                return Disposables.create()
        }
    }
    @discardableResult // 중복있는지 검사
    func saveList<T:Codable & Equatable>(data: T, forkey Key: type) -> Observable<[T]> {
        
        return Observable.create { observable in
            let defaults = UserDefaults.standard
            let encoder = JSONEncoder()
            
            var existingList = [T]()
            
            // Load
            if let loadData = defaults.object(forKey: Key.key) as? Data,
               let loadList = try? JSONDecoder().decode([T].self, from: loadData) {
                existingList = loadList
            }
            if existingList.contains(data){
                observable.onNext(existingList)
                observable.onCompleted()
            }
            // append
            existingList.append(data)
            
            // encode
            do {
                let save = try encoder.encode(existingList)
                defaults.set(save, forKey: Key.key)
                observable.onNext(existingList)
                observable.onCompleted()
            }
            catch {
                observable.onError(UserDefaultsError.canDecode)
            }
            return Disposables.create()
        }
    }
    
    
    @discardableResult /// 기본내장타입만 된다니....?
    func loadOf<T:Codable & Equatable>(data: T.Type, forkey key: type) -> Observable<T> {

        return UserDefaults.standard.rx.observe(data, key.key)
            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
            .compactMap({ $0 })
            .debug()
    }
    
    @discardableResult
    func loadList<T:Codable & Equatable>(data: T.Type, forkey Key: type) -> Observable<[T]> {
        
        return Observable.create { [weak self] observable in
            guard let self else {
                observable.onError(UserDefaultsError.canDecode)
                return Disposables.create()
            }
            let defaults = UserDefaults.standard
            let decoder = JSONDecoder()
            
            let result = self.loadList(data, forKey: .recent)
            observable.onNext(result)
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    
    private func loadList<T:Codable & Equatable>(_ type: T.Type, forKey Key: type) -> [T] {
        let decoder = JSONDecoder()
        if let loadData = UserDefaults.standard.data(forKey: Key.key) {
            do {
                let load = try decoder.decode([T].self, from: loadData)

                return load
            } catch {
                return []
            }
        }
        return []
    }
    
}
