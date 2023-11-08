//
//  NetworkError.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/7/23.
//

import Foundation

enum NetworkError: Error {
    case BadUrl
    case NoData
    case DecodingError
    case NoApiKey
}
