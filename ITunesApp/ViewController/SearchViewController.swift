//
//  SearchViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/5/24.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        UrlRequestAssistance.shared.requestAF(type: ITunes.self , router: .search(term: "카카오톡"))
        
    }
    
}
