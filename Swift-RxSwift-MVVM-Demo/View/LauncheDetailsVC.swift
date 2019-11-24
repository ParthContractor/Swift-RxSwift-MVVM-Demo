//
//  LauncheDetailsVC.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class LauncheDetailsVC: UIViewController {
    public var selectedLaunchFlightNumber : Int
    private let tableView = UITableView()
    private let cellIdentifier = "launcheDetailsCellIdentifier"
    private var rocketWikiURL: URL!

    // MARK: - initilisers
    init(flightNumber:Int){
        self.selectedLaunchFlightNumber = flightNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewModel = LauncheDetailsVCViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        view.backgroundColor = .white
        self.viewModel.requestLaunchData(flightNumber: selectedLaunchFlightNumber)
        setupBinding()
    }
    
    private func initialSetUp() {
        let rocketWiki = UIBarButtonItem(title: "RocketWiki", style: .done, target: self, action: nil)
        self.navigationItem.rightBarButtonItem  = rocketWiki
        rocketWiki.rx.tap.bind { item in
            let safari = SFSafariViewController(url: self.rocketWikiURL)
            safari.modalPresentationStyle = .overFullScreen
            self.present(safari, animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
        
        view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()
        tableView.register(LauncheDetailsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    // MARK: - Bindings
    private func setupBinding() {
        // observing errors to show
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                self.presentAlert(withTitle: "SpaceX Launch Details", message: error)
            })
            .disposed(by: disposeBag)
        
        // binding data to tableview
        viewModel
            .launchDetails
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
                let strLaunchSuccessful = (model.isLaunchSuccessful ?? false) ? "YES" : "NO"
                self.navigationItem.title = model.missionName
                
                cell.textLabel?.text = "Flight Num: " + "\(model.flightNumber)" + "\n" +
                    "Launch Year: " + "\(model.launchYear)" + "\n" +
                    "Launch Successful: " + strLaunchSuccessful + "\n" +
                    "Launch Window: " + "\(String(describing: model.launchWindow ?? 0))" + "\n" +
                    "Rocket used: " + "\(model.rocket.rocketName)" + "\n"
        }
        .disposed(by: disposeBag)
        
        viewModel.rocketDetails.asObservable()
        .bind { [weak self] (rocketModel) in
            let url = URL(string: rocketModel.wikipedia ?? "")
            self?.rocketWikiURL = url
        }
        .disposed(by: disposeBag)
    }
    
}
