//
//  LaunchesListVC.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 23/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LaunchesListVC: UIViewController {
    private let tableView = UITableView()
    private let cellIdentifier = "launchesCellIdentifier"
    var viewModel = LaunchesListVCViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        viewModel.requestData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBinding()
    }

    private func initialSetUp() {
        tableView.register(LaunchesTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.title = "SpaceX Launches"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    private func setupBinding() {
       // observing errors to show
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                self.presentAlert(withTitle: "SpaceX Launches", message: error)
                })
            .disposed(by: disposeBag)

        // binding data to tableview
        viewModel
        .launches
        .observeOn(MainScheduler.instance)
        .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
            cell.textLabel?.text = "Flight Num: " + "\(model.flightNumber)"
            cell.detailTextLabel?.text = "Mission: " + model.missionName
            cell.textLabel?.adjustsFontSizeToFitWidth = true
        }
        .disposed(by: disposeBag)
    }
}

