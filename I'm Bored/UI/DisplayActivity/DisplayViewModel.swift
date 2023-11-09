//
//  DisplayViewModel.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/9/23.
//

import Foundation

@MainActor
class DisplayViewModel: ObservableObject {
    private var activityUrl: String = ""
    private let boredActivity = BoredActivity()
    private let pexelsClient = PexelsImages()
    
    @Published private (set) var activity: String = ""
    @Published private (set) var boredImage: BoredImage?
    @Published private (set) var errorMsg: String?
    
    init(url: String) {
        activityUrl = url
        fetchActivity()
    }

    private func fetchActivity() {
        boredActivity.fetchActivity(urlStr: activityUrl) { result in
            switch result {
                case .success(let boredActivity):
                    self.activity = boredActivity
                    self.fetchImage(query: self.activity)
                case.failure(let error):
                    switch error {
                        case .ApiError: self.errorMsg = "Bored API Error."
                        case .NetworkError: self.errorMsg = "Network error."
                        default: self.errorMsg = "Network error"
                    }
            }
        }
    }
    
    private func fetchImage(query: String) {
        pexelsClient.fetchImageUrl(query: query) { result in
            switch result {
                case .success(let newBoredImage):
                    self.boredImage = newBoredImage ?? BoredImage()
                case .failure(let error):
                    switch error {
                        case .ApiError: self.errorMsg = "Bored API Error."
                        case .NetworkError: self.errorMsg = "Network error."
                        case .Retry: self.fetchImage(query: "Cleaning") // No result. Retry with cleaning.
                    }
            }
        }
    }
}
