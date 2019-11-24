//
//  LaunchesListVCViewModel.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import RxSwift
import RxCocoa

enum QueryData {
    case ALL(_ data: [String: String] = [String: String]())
    case SortByMissionName(data: [String: String] = ["sort": "mission_name","order": "asc"])
    case SortByLaunchDate(data: [String: String] = ["sort": "launch_date_utc","order": "launch_year"])
    case FilterBySuccessfulLaunch(data: [String: String] = ["launch_success": "true"])
    

    func associatedValue() -> [String: String] {
      switch self {
      case .ALL(let value):
        return value
      case .SortByMissionName(let value):
        return value
      case .SortByLaunchDate(let value):
        return value
      case .FilterBySuccessfulLaunch(let value):
        return value
      }
    }
}

class LaunchesRequest: APIRequest {
    var method = RequestType.GET
    var path = "launches"
    var parameters = [String: String]()
    
    init(params: [String: String]) {
        self.parameters = params
    }
}

class LaunchesListVCViewModel {
        
    public let launches : PublishSubject<[LaunchModel]> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()

    private let disposable = DisposeBag()
    
    private let apiClient = APIClient()

    public func requestData(_ queryData: QueryData = .ALL()){
        self.loading.onNext(true)
        let apiRequestSetUp = LaunchesRequest(params: queryData.associatedValue())
        let apiReq = apiRequestSetUp.request(with: AppConstants.baseURL)
        
        APIClient.requestData(responseObjeType:[LaunchModel].self, apiRequest: apiReq, completionHandler: { result,error  in
            self.loading.onNext(false)
            //Error if any
            if let err = error {
                self.error.onNext(err.localizedDescription)
            }
            
            //result if anything
            if let result = result {
                self.launches.onNext(result)
            }
        })        
    }
}


