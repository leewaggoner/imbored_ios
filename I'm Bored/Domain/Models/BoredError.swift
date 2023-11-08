//
//  BoredError.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/7/23.
//

import Foundation

enum BoredError: Error {
    case ApiError
    case NetworkError
    case Retry
}
