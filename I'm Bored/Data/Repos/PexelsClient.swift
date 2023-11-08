//
//  PexelsClient.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/6/23.
//

import Foundation

private let MAX_RETRIES = 3

class PexelsClient {
    private var retryCount: Int = 0
    
    func fetchImageUrl(query: String, completion: @escaping(Result<BoredImage?, BoredError>) -> Void) {
        callPexelsApi(query: query) { result in
            switch result {
                case .success(let pexelsData):
                    DispatchQueue.main.async {
                        let boredImage = pexelsData?.mapToBoredImage()
                        if (boredImage?.url != nil) {
                            completion(.success(boredImage))
                        } else {
                            completion(.failure(self.handleRetry()))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let boredError = switch error {
                            case .BadUrl: BoredError.ApiError
                            case .DecodingError: self.handleRetry()
                            case .NoApiKey: BoredError.ApiError
                            case .NoData: BoredError.NetworkError
                        }
                        completion(.failure(boredError))
                    }
            }
        }
    }
    
    private func handleRetry() -> BoredError {
        if (self.retryCount < MAX_RETRIES) {
            self.retryCount += 1
            return .Retry
        } else {
            self.retryCount = 0
            return.ApiError
        }
    }
    
    private func callPexelsApi(query: String, completion: @escaping(Result<PexelsResponse?, NetworkError>) -> Void) {
        guard let url = URL.pexelsUrl(query: query) else {
            return completion(.failure(.BadUrl))
        }
        
        guard let apiKey = Bundle.main.infoDictionary?["PEXELS_API_KEY"] as? String else {
            return completion(.failure(.NoApiKey))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            let pexelsResponse = try? JSONDecoder().decode(PexelsResponse.self, from: data)
            if let pexelsResponse = pexelsResponse {
                self.retryCount = 0
                completion(.success(pexelsResponse))
            } else {
                completion(.failure(.DecodingError))
            }
        }.resume()
    }
}
