//
//  PexelsImageSource.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/6/23.
//

import Foundation

struct PexelsImageSource: Codable {
    var original: String
    var large2x: String
    var large: String
    var medium: String
    var small: String
    var portrait: String
    var landscape: String
    var tiny: String
}
