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
                    if !activityData.activity.isEmpty {
                        completion(.success(activityData.activity))
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
            let boredActivityResponse = try? JSONDecoder().decode(BoredActivityResponse.self, from: data)
            if let boredActivityResponse = boredActivityResponse {
                completion(.success(boredActivityResponse))
            }
        }.resume()
    }
}
