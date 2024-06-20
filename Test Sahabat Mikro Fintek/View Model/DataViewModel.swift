//
//  DataViewModel.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import Foundation

class DataViewModel{
    
    private let networkService = NetworkingService()
    typealias CompletionHandler = (_ success: Bool?, _ data: [DataModel]?)->Void
    
    func getLoanList(completion: @escaping CompletionHandler){
        networkService.requestGET(expecting: [DataModel].self, endpoint: "/api/json/loans.json")
        { result in
            switch result{
            case.success(let data):
                completion(true, data)
            case .failure(let error):
                print(error)
                completion(false,nil)
            }
        }
    }
    
}

