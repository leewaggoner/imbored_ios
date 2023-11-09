//
//  DisplayActivity.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/9/23.
//

import SwiftUI

struct DisplayActivity: View {
    @StateObject var viewModel: DisplayViewModel
    

    var body: some View {
        VStack {
            Text("Why don't you")
                .font(.system(size: 36))
                .fontWeight(.bold)
            Text(viewModel.activity)
                .font(.system(size: 28))
                .multilineTextAlignment(.center)
            BoredImageView(boredImage: viewModel.boredImage ?? BoredImage())
                .frame(height: 400)
        }
        .padding(16)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .toolbarBackground(Color("Colors/Tertiary"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    DisplayActivity(
        viewModel: DisplayViewModel(
            url: "https://www.boredapi.com/api/activity?type=busywork"
        )
    )
}
