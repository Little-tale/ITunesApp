//
//  AppDetailViewController.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa

final class AppDetailViewController: BaseViewController<AppDetailView> {
    
    private let viewModel = AppDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
    }
    
    func setModel(_ model: SearchResult) {
        let model = BehaviorSubject(value: model)
        
        let input = AppDetailViewModel.Input(inputModel: model)
        
        let output = viewModel.transform(input)

        homeView.appinfo.settingModel(output.outputAppInfo)
        
        homeView.detailView.setModel(output.outAppDetailInfo)
        
        homeView.imageScrollView.setModel(output.outImages)
        
        homeView.detailIntroduceView.setModel(output.outIntroduce)
        
    }
    
    private func navigationSetting(){
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
