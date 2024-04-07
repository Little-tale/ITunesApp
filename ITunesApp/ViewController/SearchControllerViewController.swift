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
final class SearchControllerViewController: UIViewController, LayoutProtocol {
    
    let appInfoTableView = UITableView(frame: .zero)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    let disposeBag = DisposeBag()
    
    let viewModel = SearchResultsViewModel()
    
    weak var pushDelegate: PushViewController?
    
    private let searchQuerySub = PublishSubject<String> ()
    
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
        view.addSubview(collectionView)
        view.addSubview(appInfoTableView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        appInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
        
    
    func designView() {
        
        appInfoTableView.backgroundColor = .systemBackground
        
        appInfoTableView.estimatedRowHeight = 120
        appInfoTableView.rowHeight = UITableView.automaticDimension
        appInfoTableView.separatorStyle = .none
        
        
    }
    
    
    private func subscribe(){
        let selectedRecented = PublishSubject<RecentModel> ()
        
        let input = SearchResultsViewModel.Input(
            searchText: searchQuerySub,
            recentSelected: selectedRecented
        )
        
        let output = viewModel.transform(input)
        
        // TableView Draw
        output.resultData
            .bind(
                to: appInfoTableView.rx.items(
                    cellIdentifier:
                        SearchAppInfoTableCell.identifier,
                    cellType: SearchAppInfoTableCell.self
                )
            ) { row , data , cell in
                cell.settingModel(data)
            }
            .disposed(by: disposeBag)
        // collectionView Draw
        output.recenData
            .bind(
                to: collectionView.rx.items(cellIdentifier: RecentCollectionViewCell.identifier, cellType: RecentCollectionViewCell.self)
            ) { row, data, cell in
                cell.label.text = data.appName
            }
            .disposed(by: disposeBag)
        
        
        // TableView ItemSelected
        appInfoTableView.rx.modelSelected(SearchResult.self)
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, result in
                let view = AppDetailViewController()
                view.setModel(result)
                owner.pushDelegate?.push(view)
                //owner.navigationController?.pushViewController(view, animated: true)
                
                print("????/")
            }
            .disposed(by: disposeBag)
        
        // collectionView ItemSelected
        collectionView.rx.modelSelected(RecentModel.self)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(to: selectedRecented)
            .disposed(by: disposeBag)
    }
    
    func performsearch(for query: String) {
        searchQuerySub.onNext(query)
    }
    
    
    private func registSetting(){
        appInfoTableView.register(SearchAppInfoTableCell.self, forCellReuseIdentifier: SearchAppInfoTableCell.identifier)
        
        collectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.identifier)
    }
    
}

/* 오늘
 위와 같은 방법으로 해결은 하였으나.... 너무 맘에 들지 않는데
 전역 변수로 밖엔 해결을 하지 못했을까?

 */


