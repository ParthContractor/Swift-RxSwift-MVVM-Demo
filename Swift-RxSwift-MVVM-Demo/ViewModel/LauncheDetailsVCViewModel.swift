//
//  LauncheDetailsVCViewModel.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import RxSwift
import RxCocoa

class LaunchDetailsRequest: APIRequest {
    var method = RequestType.GET
    var path = "launches"
    var parameters = [String: String]()
    
    init(flightNumber: Int) {
        self.path = path + "/" + "\(flightNumber)"
    }
}

class RocketDetailsRequest: APIRequest {
    var method = RequestType.GET
    var path = "rockets"
    var parameters = [String: String]()
    
    init(rocketId: String) {
        self.path = path + "/" + rocketId
    }
}

class LauncheDetailsVCViewModel {
    public let launchDetailsSource : PublishSubject<[Any]> = PublishSubject()

    public let launchDetails : PublishSubject<[LaunchModel]> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    public let rocketDetails : PublishSubject<RocketModel> = PublishSubject()

    private let disposable = DisposeBag()
    
    private let apiClient = APIClient()

    public func requestLaunchData(flightNumber: Int) {
        let apiRequestSetUp = LaunchDetailsRequest(flightNumber: flightNumber)
        let apiReq = apiRequestSetUp.request(with: AppConstants.baseURL)
        
        APIClient.requestData(responseObjeType:LaunchModel.self, apiRequest: apiReq, completionHandler: { result,error  in
            //Error if any
            if let err = error {
                self.error.onNext(err.localizedDescription)
            }
            
            //result if anything
            if let result = result {
                self.requestRocketData(rocketId: result.rocket.rocketId)
                self.launchDetails.onNext([result])
            }
        })
    }
    
    public func requestRocketData(rocketId: String) {
        let apiRequestSetUp = RocketDetailsRequest(rocketId: rocketId)
        let apiReq = apiRequestSetUp.request(with: AppConstants.baseURL)
        
        APIClient.requestData(responseObjeType:RocketModel.self, apiRequest: apiReq, completionHandler: { result,error  in
            //Error if any
            if let err = error {
                self.error.onNext(err.localizedDescription)
            }
            
            //result if anything
            if let result = result {
                self.rocketDetails.onNext(result)
            }
        })
    }
}

