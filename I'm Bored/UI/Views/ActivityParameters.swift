//
//  ParameterPicker.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/4/23.
//

import SwiftUI

struct ActivityParameters: View {
    var participantLabels: [String]
    var curParticipants = "Any"
    var costLabels: [String]
    var curCost = "Any"
    var onParticipantsChanged: (String) -> Void
    var onCostChanged: (String) -> Void
    
    var body: some View {
        HStack {
            ActivityParameterDropdown(
                label: "Participants",
                menuLabels: participantLabels,
                onSelectionChanged: onParticipantsChanged
            )
            ActivityParameterDropdown(
                label: "Cost",
                menuLabels: costLabels,
                onSelectionChanged: onCostChanged
            )
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

#Preview {
    @StateObject var viewModel = ChooseViewModel()
    return ActivityParameters(
        participantLabels: viewModel.participantLabels,
        curParticipants: viewModel.curParticipants,
        costLabels: viewModel.costLabels,
        curCost: viewModel.curCost,
        onParticipantsChanged: { participants in
            viewModel.onParticipantsChanged(participants: participants)
        }, 
        onCostChanged: { cost in
            viewModel.onCostChanged(cost: cost)
        }
    )
}

