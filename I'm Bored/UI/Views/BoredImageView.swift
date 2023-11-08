//
//  BoredImageView.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/7/23.
//

import SwiftUI

struct BoredImageView: View {
    var boredImage: BoredImage
    
    init(boredImage: BoredImage) {
        self.boredImage = boredImage
    }
    
    var body: some View {
        VStack {
            let url = URL(string: boredImage.url)
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()

            Text(.init(buildAttributionText(boredImage: boredImage)))
                .font(.system(size: 12))
        }
    }
    
    private func buildAttributionText(boredImage: BoredImage) -> String {
        return "Photo by [\(boredImage.photographer)](\(boredImage.photographerUrl)) on [\(boredImage.imageHost)](\(boredImage.imageHostUrl))"
    }
}

#Preview {
    return BoredImageView(
        boredImage: BoredImage(
            url: "https://cdn.hswstatic.com/gif/largest-desert-world.jpg",
            photographer: "I.M. Photographer",
            photographerUrl: "https://www.google.com"
        )
    )
}

