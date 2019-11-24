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
    private let segmentedControl = UISegmentedControl()
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
        let items = ["All", "Sort By MissionName", "Sort By LaunchDate", "Filter By Successful Launch"]
        let customSC = UISegmentedControl(items: items)
        customSC.tintColor = .red
        customSC.backgroundColor = UIColor.ThemeColor.navigationBarTintColor
        customSC.translatesAutoresizingMaskIntoConstraints = false
        customSC.selectedSegmentIndex = 0
        view.addSubview(customSC)
        view.addSubview(tableView)
        
        customSC.addTarget(self, action: #selector(LaunchesListVC.segmentedControlChanged(_:)), for: .valueChanged)

        NSLayoutConstraint.activate([
            customSC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customSC.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            customSC.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            customSC.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])

        tableView.register(LaunchesTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.title = "SpaceX Launches"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: customSC.bottomAnchor),
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
        }
        .disposed(by: disposeBag)
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.requestData()
        case 1:
            viewModel.requestData(.SortByMissionName())
        case 2:
            viewModel.requestData(.SortByLaunchDate())
        case 3:
            viewModel.requestData(.FilterBySuccessfulLaunch())
        default:
            viewModel.requestData()
        }
    }
}

