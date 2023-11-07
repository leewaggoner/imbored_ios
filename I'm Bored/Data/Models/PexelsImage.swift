//
//  PexelsImage.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/6/23.
//

import Foundation

struct PexelsImage: Codable {
    var id: Int
    var width: Int
    var height: Int
    var url: String
    var photographer: String
    var photographerUrl: String
    var src: PexelsImageSource
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case photographer
        case photographerUrl = "photographer_url"
        case src
    }
}
