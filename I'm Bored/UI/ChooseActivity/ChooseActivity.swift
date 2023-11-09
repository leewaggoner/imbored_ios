//
//  ContentView.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/2/23.
//

import SwiftUI

struct ChooseActivity: View {
    @State private var path = NavigationPath()
    @StateObject private var viewModel = ChooseViewModel()
    
    init() {
        UINavigationBar.appearance()
        .largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color("Colors/TextWhite"))
        ]
    }
    
    var body: some View {
        NavigationStack(path: $path) {
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
                        path.append("DisplayScreen")
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
                .navigationDestination(for: String.self) { view in
                    if view == "DisplayScreen" {
                        DisplayActivity(
                            viewModel: DisplayViewModel(
                                url: viewModel.getActivityUrl()
                            )
                        )
                    }
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .navigationTitle("I'm Bored")
            .toolbarBackground(Color("Colors/Tertiary"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    ChooseActivity()
}
