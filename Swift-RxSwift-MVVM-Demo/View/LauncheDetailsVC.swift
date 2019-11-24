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
    private var selectedLaunchFlightNumber : Int
    private let tableView = UITableView()
    private var rocketWiki: UIBarButtonItem!
    private let cellIdentifier = "launcheDetailsCellIdentifier"
    private var rocketWikiURL: URL!
    var viewModel = LauncheDetailsVCViewModel()
    let disposeBag = DisposeBag()

    // MARK: - initilisers
    init(flightNumber:Int){
        self.selectedLaunchFlightNumber = flightNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initial Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        view.backgroundColor = .white
        self.viewModel.requestLaunchData(flightNumber: selectedLaunchFlightNumber)
        setupBinding()
    }
    
    private func initialSetUp() {
        rocketWiki = UIBarButtonItem(title: "RocketWiki", style: .done, target: self, action: nil)
        self.navigationItem.rightBarButtonItem  = rocketWiki
        view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()
        tableView.register(LauncheDetailsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutAndConstraintsSetup()
    }

    // MARK: - Bindings
    private func setupBinding() {
        // loading indicator binding
        viewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)

        // binding data to barButton tap action
        setUpWikiBinding()
        // observing errors to show
        setUpErrorBinding()
        // binding data to tableview
        setUpLaunchAndRocketDetailsBinding()
    }
    
    private func setUpWikiBinding() {
        viewModel.launchDetailsSource.asObservable()
        .bind { [weak self] (rocketModel) in
            let url = URL(string: rocketModel[0].1.wikipedia ?? "")
            self?.rocketWikiURL = url
        }
        .disposed(by: disposeBag)

        //setting up wiki info binding
        rocketWiki.rx.tap.bind { item in
            let safari = SFSafariViewController(url: self.rocketWikiURL)
            safari.modalPresentationStyle = .overFullScreen
            self.present(safari, animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
    }
    
    private func setUpErrorBinding() {
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                self.presentAlert(withTitle: "SpaceX Launch Details", message: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpLaunchAndRocketDetailsBinding() {
        viewModel
            .launchDetailsSource
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
                let strLaunchSuccessful = (model.0.isLaunchSuccessful ?? false) ? "YES" : "NO"
                let rocketSuccessRatio = "\(model.1.successRate ?? 0)"
                self.navigationItem.title = model.0.missionName
                
                cell.textLabel?.text = "Flight Num: " + "\(model.0.flightNumber)" + "\n" +
                    "Launch Year: " + "\(model.0.launchYear)" + "\n" +
                    "Launch Successful: " + strLaunchSuccessful + "\n" +
                    "Launch Window: " + "\(String(describing: model.0.launchWindow ?? 0))" + "\n" +
                    "-----------------------" + "\n" +
                    "Details of rocket used for the mission:" + "\n" +
                    "-----------------------" + "\n" +
                    "Rocket used: " + "\(model.0.rocket.rocketName)" + "\n" +
                    "Rocket type: " + "\(model.1.rocketType)" + "\n" +
                    "Success ratio: " + "\(rocketSuccessRatio) %" + "\n" +
                    "Country: " + "\(model.1.country ?? AppConstants.dataUnAvailable)" + "\n" +
                    "Company: " + "\(model.1.company ?? AppConstants.dataUnAvailable)" + "\n" +
                    "Cost per launch: " + "\(model.1.costPerLaunch ?? 0)" + "\n" +
                    "Description: " + "\(model.1.description ?? AppConstants.dataUnAvailable)" + "\n" +
                    "First flight: " + "\(model.1.firstFlight ?? AppConstants.dataUnAvailable)" + "\n" +
                    "Height: " + "\(model.1.height?.meters ?? 0) meters" + "\n" +
                    "Diameter: " + "\(model.1.diameter?.meters ?? 0) meters" + "\n" +
                    "Mass: " + "\(model.1.mass?.kg ?? 0) Kg" + "\n"
        }
        .disposed(by: disposeBag)
    }
    
    // MARK: - Layout and constraints setup
    private func layoutAndConstraintsSetup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }

}
