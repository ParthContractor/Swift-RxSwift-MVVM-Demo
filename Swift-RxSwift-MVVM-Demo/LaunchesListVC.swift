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
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
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
}

