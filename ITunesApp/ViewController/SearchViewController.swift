//
//  SearchViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/5/24.
//

import UIKit
import RxSwift
import Then
import RxCocoa

protocol PushViewController: AnyObject {
    
    func push(_ changeVieController: UIViewController)
    
}


class SearchViewController: UIViewController {
    
    private let rootViewController = SearchControllerViewController()
    
    private lazy var nextSearchViewController = rootViewController //UINavigationController(rootViewController: rootViewController)
    
    private lazy var homeView = SearchHomeView(resultViewController: nextSearchViewController, frame: .zero)
    
    private let rightBarButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "star")
    }
    
    let disposeBag = DisposeBag()
    
    let viewModel = SearchControllerViewModel()
    
    override func loadView() {
        super.loadView()
        view = homeView
        homeView.backgroundColor = .white
        rootViewController.pushDelegate = self
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
        
        navigationItem.rightBarButtonItem = rightBarButton
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
                owner.rootViewController
                    .performsearch(for: searchText)
            }.disposed(by: disposeBag)
        
        
        //////
        rightBarButton.rx.tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in

                let vc = DownloadAppViewController()
                vc.modalPresentationStyle = .popover
                owner.present(vc, animated: true)
                
            }
            .disposed(by: disposeBag)
        
    }
    
}

extension SearchViewController: PushViewController {
    
    func push(_ changeVieController: UIViewController) {
        navigationController?.pushViewController(changeVieController, animated: true)
    }
}
