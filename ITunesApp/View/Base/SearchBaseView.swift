//
//  SearchBaseView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit

class SearchBaseView: BaseView {
    
    let resultViewController: UIViewController?
    
    lazy var searchController = UISearchController(searchResultsController: resultViewController)
    
    init(resultViewController: UIViewController?, frame: CGRect) {
        self.resultViewController = resultViewController
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    deinit {
        print("deinit: SearchBaseView")
    }
}
