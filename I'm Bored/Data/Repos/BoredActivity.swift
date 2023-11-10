//
//  BoredActivity.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/9/23.
//

import Foundation

struct BoredActivity {
    func fetchActivity(urlStr: String, completion: @escaping(Result<String, BoredError>) -> Void) {
        callBoredApi(urlStr: urlStr) { result in
            switch result {
            case .success(let activityData):
                DispatchQueue.main.async {
                    if activityData.error == nil {
                        completion(.success(activityData.activity ?? ""))
                    } else {
                        completion(.success("Try again\n\n\(activityData.error ?? "")"))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let boredError = switch error {
                        case .BadUrl: BoredError.ApiError
                        case .DecodingError: BoredError.ApiError
                        case .NoApiKey: BoredError.ApiError
                        case .NoData: BoredError.NetworkError
                    }
                    completion(.failure(boredError))
                }
            }
        }
    }
    
    private func callBoredApi(urlStr: String, completion: @escaping(Result<BoredActivityResponse, NetworkError>) -> Void) {
        guard let url = URL(string: urlStr) else { return completion(.failure(.BadUrl)) }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.success(BoredActivityResponse()))
            }
            let bodyString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            let responseLog = "\n\(bodyString)\n"
            print(responseLog)

            var boredActivityResponse = try? JSONDecoder().decode(BoredActivityResponse.self, from: data)
                
            print("\(boredActivityResponse ?? BoredActivityResponse(error: "Null"))")
            if let boredActivityResponse = boredActivityResponse {
                completion(.success(boredActivityResponse))
            }
        }.resume()
    }
}
