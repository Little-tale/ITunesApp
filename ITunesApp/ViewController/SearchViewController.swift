//
//  SearchViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/5/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    private let nextSearchViewController = SearchControllerViewController()
    
    private lazy var homeView = SearchHomeView(resultViewController: nextSearchViewController, frame: .zero)
    
    let disposeBag = DisposeBag()
    
    let viewModel = SearchControllerViewModel()
    
    override func loadView() {
        super.loadView()
        view = homeView
        homeView.backgroundColor = .white
        subscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation()
    }
    
    
    private func settingNavigation(){
        navigationItem.searchController = homeView.searchController
        navigationItem.title = "검색"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func subscribe(){
        let searchConText = homeView.searchController.searchBar.rx.text
        
        let searchConTap = homeView.searchController.searchBar.rx.searchButtonClicked
        
        let input = SearchControllerViewModel
            .Input(
                searchConText: searchConText,
                searchConTap: searchConTap
            )
        let output = viewModel.transform(input)
        
        output.searchText
            .bind(with: self) { owner, searchText in
                owner.nextSearchViewController
                    .performsearch(for: searchText)
            }.disposed(by: disposeBag)
    }
    
}
