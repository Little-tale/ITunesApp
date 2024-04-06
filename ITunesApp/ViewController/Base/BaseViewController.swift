//
//  BaseViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit


class BaseViewController<T: BaseView>: UIViewController {
    
    let homeView = T()
    
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
