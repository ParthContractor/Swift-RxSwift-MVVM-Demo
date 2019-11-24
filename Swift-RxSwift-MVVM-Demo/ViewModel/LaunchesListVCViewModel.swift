//
//  LaunchesListVCViewModel.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import RxSwift
import RxCocoa

class LaunchesRequest: APIRequest {
    var method = RequestType.GET
    var path = "launches"
    var parameters = [String: String]()
}

class LaunchesListVCViewModel {
        
    public let launches : PublishSubject<[LaunchModel]> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    private let apiClient = APIClient()

    public func requestData(){
        let apiRequestSetUp = LaunchesRequest()
        let apiReq = apiRequestSetUp.request(with: AppConstants.baseURL)
        
        APIClient.requestData(responseObjeType:[LaunchModel].self, apiRequest: apiReq, completionHandler: { result,error  in
            //Error if any
            if let _ = error {
                print("error")
            }
            
            //result if anything
            if let result = result {
                self.launches.onNext(result)
            }
        })        
    }
}


