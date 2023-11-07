//
//  UrlExtension.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/6/23.
//

import Foundation

extension URL {
    static func pexelsUrl(query: String) -> URL? {
//        if let apiKey = Bundle.main.infoDictionary?["PEXELS_API_KEY"] as? String {
            guard let url = URL(string: "https://api.pexels.com/v1/search?query=\(query)&per_page=1") else { return nil }
            return url
//        }
//        return nil
    }
}
