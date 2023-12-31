//
//  PexelsResponse.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/6/23.
//

import Foundation

struct PexelsResponse: Codable {
    var totalResults: Int
    var page: Int
    var perPage: Int
    var photos: [PexelsImage]
    var nextPage: String
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case perPage = "per_page"
        case photos
        case nextPage = "next_page"
    }
    
    func mapToBoredImage() -> BoredImage {
        var boredImage = BoredImage()
        boredImage.url = photos[0].src.portrait
        boredImage.photographer = photos[0].photographer
        boredImage.photographerUrl = photos[0].photographerUrl
        return boredImage
    }
}
