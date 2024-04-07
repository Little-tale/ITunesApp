//
//  DownloadAppViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

class DownloadAppViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        setUI()
        register()
        subscribe()
    }
    let disposeBag = DisposeBag()
    let viewModel = DownloadAppViewModel()
    
    private func register(){
        tableView.register(AppInfoTableCell.self, forCellReuseIdentifier: AppInfoTableCell.identifier)
    }
    
    private func subscribe(){
        let input = DownloadAppViewModel.Input(viewWillAppear: rx.viewWillAppear)
        
        let output = viewModel.transform(input)
        
        output.outApps.bind(
            to: tableView.rx.items(
                cellIdentifier: AppInfoTableCell.identifier, cellType: AppInfoTableCell.self
            )
        ) {
            row, value, cell in
            print(value)
            cell.setModel(value)
        }
        .disposed(by: disposeBag)
        
    }
    private func setUI(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}


