//
//  BaseView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import RxSwift

class BaseView: UIView, LayoutProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        all()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let rxDisPoseBag = DisposeBag()
    
    func all(){
        configureHierarchy()
        configureLayout()
        designView()
        register()
        subscribe()
        tester()
    }
    
    func configureHierarchy(){
        
    }
    func configureLayout(){
        
    }
    func designView(){
        
    }
    func register(){
        
    }
    func subscribe(){
        
    }
    func tester(){
        
    }
}
