//
//  NetworkService.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import Foundation

class NetworkingService{
    let prefixURL = GlobalVariable.prefixURL
    
    //MARK: - Retrieve Data (get method)
    func requestGET<T:Decodable>(expecting: T.Type,
                                 endpoint: String,
                                 completion: @escaping (Result<T, Error>) -> Void){
        
        
        guard let url = URL(string:prefixURL + endpoint) else{
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                
                print("\(response.statusCode) - \(endpoint)")
            
                if let data = data {
                    do{
                        if let user = try? JSONDecoder().decode(expecting.self, from: data){
                            completion(.success(user))
                        }else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            completion(.failure(errorResponse))
                        }
                    }catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

enum NetworkingError: Error{
    case badUrl
    case badResponse
}
