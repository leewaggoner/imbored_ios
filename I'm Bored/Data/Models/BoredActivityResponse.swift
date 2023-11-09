//
//  BoredActivity.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/9/23.
//

import Foundation

struct BoredActivityResponse: Decodable {
    var activity: String = ""
    var accessibility: Float = 0.0
    var type: String = ""
    var participants: Int = 0
    var price: Float = 0.0
    var error: String? = nil
}
