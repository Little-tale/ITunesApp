//
//  Extention.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa

extension UIView  {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension Double {
    var rounded2: String {
        return NumberAssistance.shared.roundedNum(self, 2)
    }
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}
extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}


// MARK: Rx ViewWillAppear
extension Reactive where Base: UIViewController {
    
    var viewWillAppear: ControlEvent<Bool> {
        let source = methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        print("viewWillAppear Load Complite ~~!~!~!~!")
        return ControlEvent(events: source)
    }
    
}


extension UIViewController {
    
    func showAlert(title: String, message: String? = nil) -> Observable<String> {
        
        return Observable.create { [weak self] observable in
            let alertControlelr = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let currectAction = UIAlertAction(title: "OK", style: .default) {
                _ in
                observable.onNext(title)
                observable.onCompleted()
            }
            alertControlelr.addAction(currectAction)
            
            self?.present(alertControlelr, animated: true)
            
            return Disposables.create {
                alertControlelr.dismiss(animated: true)
            }
        }
    }
    
}
