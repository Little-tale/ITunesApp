//
//  SearchHomeView.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit


class SearchHomeView: SearchBaseView {
    
    
    override init(resultViewController: UIViewController?, frame: CGRect) {
        super.init(resultViewController: resultViewController, frame: frame)
        settingSearchController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingSearchController(){
        searchController.searchBar.placeholder = "게임, 앱, 스토리등"
        
        if let resultViewController {
            searchController.showsSearchResultsController = true
        }
    }
    
}
