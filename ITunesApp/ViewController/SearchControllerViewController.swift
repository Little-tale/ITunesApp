//
//  SearchControllerViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

/*
 모던 컬렉션뷰로 진행하려 했으나 생각보다 너무 복잡해짐
 1. [결과] 이형태 인데 내 생각엔 결과가 색션이 돠어야 한다고 생각했음
 2. 하나의 섹션의 2개의 셀을 구성하여 각 필요한 모델만 던져 주려 했음
 3. 하지만 생각 보다 이상함 디퍼블 데이터 소스 부분이 너무 애매해짐
 4. 그렇다고 String String으로 Identi 주어 그릴때마다 순회한다? 너무 이상함
 */
class SearchControllerViewController: UIViewController, LayoutProtocol {
    
    let appInfoTableView = UITableView(frame: .zero)
    
    let disposeBag = DisposeBag()
    
    let viewModel = SearchResultsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        designView()
        registSetting()
        subscribe()
    }
    
    func configureHierarchy() {
        view.addSubview(appInfoTableView)
    }
    
    func configureLayout() {
        appInfoTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func designView() {
        appInfoTableView.backgroundColor = .systemGreen
    }
    
    
    private func subscribe(){
        
     /*
      cellIdentifier: SearchAppInfoTableCell.identifier, cellType: SearchAppInfoTableCell.self
      */
    }
    
    func performsearch(for query: String) {
        let queryJust = Observable.just(query)
        
        let input = SearchResultsViewModel.Input(searchText: queryJust)
        
        let output = viewModel.transform(input)
        
        // TableView Draw
        output.resultData
            .bind(
                to: appInfoTableView.rx.items(
                    cellIdentifier: SearchAppInfoTableCell.identifier,
                    cellType: SearchAppInfoTableCell.self
                )
            ) { row , data , cell in
                cell.appNameLabel.text = data.artistName
            }.disposed(by: disposeBag)
    }
    
    
    
    
    private func registSetting(){
        appInfoTableView.register(SearchAppInfoTableCell.self, forCellReuseIdentifier: SearchAppInfoTableCell.identifier)
        appInfoTableView.estimatedRowHeight = 120
        appInfoTableView.rowHeight = UITableView.automaticDimension
    }
    
}



