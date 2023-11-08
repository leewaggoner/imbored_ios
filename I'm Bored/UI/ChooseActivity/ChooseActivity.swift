//
//  ContentView.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/2/23.
//

import SwiftUI

struct ChooseActivity: View {
    @StateObject private var viewModel = ChooseViewModel()
    
    init() {
        UINavigationBar.appearance()
        .largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color("Colors/TextWhite"))
        ]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollableTabBar(
                    items: viewModel.tabItems,
                    selected: viewModel.curSelection
                ) { newIndex in
                    viewModel.changeTabSelection(index: newIndex)
                }
                .padding(.bottom)
                ActivityParameters(
                    participantLabels: viewModel.participantLabels,
                    costLabels: viewModel.costLabels,
                    onParticipantsChanged: { participants in
                        viewModel.onParticipantsChanged(participants: participants)
                    },
                    onCostChanged: { cost in
                        viewModel.onCostChanged(cost: cost)
                    }
                )
                Spacer(minLength: 32)
                BoredImageView(boredImage: viewModel.boredImage ?? BoredImage())
                    .frame(height: 400)
                Button(
                    action: {
                    print("tapped!")
                    }, label: {
                        Text("Continue")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 40)
                            .background(Color("Colors/Primary"))
                            .cornerRadius(12)
                            .padding()
                    }
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .navigationTitle("I'm Bored")
        }
    }
}

#Preview {
    ChooseActivity()
}
