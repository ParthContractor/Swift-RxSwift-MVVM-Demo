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
    
    // MARK: - Iitial Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SpaceX Launches"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        initialSetUp()
        viewModel.requestData()
        setupBinding()
    }
    
    private func initialSetUp() {
        let items = ["All", "Sort By MissionName", "Sort By LaunchDate", "Successful Launches"]
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: customSC.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    // MARK: - Actions/Events
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
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
    
    // MARK: - Bindings
    private func setupBinding() {
        // loading indicator binding
        viewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        // observing errors to show
        setUpErrorBinding()
        // binding data to tableview
        setUpLaunchesListBinding()
    }
    
    private func setUpErrorBinding() {
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                self.presentAlert(withTitle: "SpaceX Launches", message: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpLaunchesListBinding() {
        //Deselect row
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
        
        // binding data to tableview
        viewModel
        .launches
        .observeOn(MainScheduler.instance)
        .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
            cell.textLabel?.text = "Flight Num: " + "\(model.flightNumber)"
            cell.detailTextLabel?.text = "Mission: " + model.missionName
        }
        .disposed(by: disposeBag)
        

        // selecting launch and navigate to details
        tableView.rx.modelSelected(LaunchModel.self)
            .subscribe(onNext: { item in
                print(item)
                let launchesListVC = LauncheDetailsVC(flightNumber: item.flightNumber)
                self.navigationController?.pushViewController(launchesListVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

