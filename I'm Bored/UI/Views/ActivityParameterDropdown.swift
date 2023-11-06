//
//  ActivityParameterDropdown.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/4/23.
//

import SwiftUI

struct ActivityParameterDropdown: View {
    var label: String
    var menuLabels: [String]
    @State var curSelection = "Any"
    var onSelectionChanged: (String) -> Void
    
    var body: some View {
        VStack {
            Menu {
                Picker(
                    selection: $curSelection,
                    label: EmptyView(),
                    content:  {
                        ForEach(menuLabels, id: \.self) { label in
                            Text(label)
                        }
                    }
                )
                .pickerStyle(.automatic)
                .accentColor(.white)
                .onChange(of: curSelection) {
                    onSelectionChanged(curSelection)
                }
            } label: {
                Text(label)
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .frame(width: 120)
            .background(Color("Colors/Picker"))
            .cornerRadius(16)
            Text(curSelection)
        }
        .frame(maxWidth: .infinity)
    }
}
    

#Preview {
    @StateObject var viewModel = ChooseViewModel()
    return ActivityParameterDropdown(
        label: "Participants",
        menuLabels: viewModel.costLabels,
        curSelection: viewModel.curCost
    ) { curSelection in
        viewModel.onParticipantsChanged(participants: curSelection)
    }
}
