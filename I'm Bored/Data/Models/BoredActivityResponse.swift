//
//  BoredActivity.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/9/23.
//

import Foundation

struct BoredActivityResponse: Decodable {
    var activity: String?
    var accessibility: Float?
    var type: String?
    var participants: Int?
    var price: Float?
    var error: String?
}
