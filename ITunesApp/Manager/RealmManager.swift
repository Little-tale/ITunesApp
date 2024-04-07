//
//  RealmManager.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//
import RxSwift
import RealmSwift


protocol RealmManagerType {
    
    // C
    func saveModel<T:Object>(_ type: RealmModelType, Object: T) -> Observable<T>
    // R
    func readModel<T:Object>(_ model: T.Type) -> Observable<[T]>
    // U
    
    // D
}
enum realmError: Error {
    case cant
}

enum RealmModelType {
    case DownApp
    
    var model: Object.Type {
        switch self {
        case .DownApp:
            return DownloadApp.self
        }
    }
    
}

final class RealmManager: RealmManagerType {
    
    
    
    private(set) var realm: Realm?

    
    init() {
        do {
           realm = try Realm()
        } catch {
            print("Realm Error 귀차넝")
        }
    }
    
    @discardableResult
    func saveModel<T: Object>(_ type: RealmModelType, Object: T) -> Observable<T>  {
        let model = type.model
        return Observable.create {[weak self] observable in
            guard let self else {
                observable.onError(realmError.cant)
                return Disposables.create()
            }
            realm?.writeAsync({
                self.realm?.add(Object)
                observable.onNext(Object)
            }, onComplete: { error in
                if let error {
                    print(error)
                    observable.onError(realmError.cant)
                }
                observable.onCompleted()

            })
            return Disposables.create()
        }
    }
    
    func readModel< T: Object > (_ model: T.Type ) -> Observable<[T]> {
        
        return Observable.create { [weak self] observable in
            guard let self,
                  let realm else {
                
                observable.onError(realmError.cant)
                return Disposables.create()
            }
            
            let results = realm.objects(model)
            let array = Array(results)
            
            observable.onNext(array)
            observable.onCompleted()
            
            return Disposables.create()
        }
        
    }
    
}
