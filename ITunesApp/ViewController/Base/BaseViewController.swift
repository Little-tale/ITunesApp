//
//  BaseViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import RxSwift


class BaseViewController<T: BaseView>: UIViewController {
    
    let homeView = T()
    
    let rxDisposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        view = homeView
        homeView.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}
