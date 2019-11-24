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

class LauncheDetailsVC: UIViewController {
    //private let tableView = UITableView()
    //private let segmentedControl = UISegmentedControl()
    //private let cellIdentifier = "launchesCellIdentifier"
    public var selectedLaunchFlightNumber : Int

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
        //        initialSetUp()
        view.backgroundColor = .white
        self.viewModel.requestLaunchData(flightNumber: selectedLaunchFlightNumber)

    }
    
}

