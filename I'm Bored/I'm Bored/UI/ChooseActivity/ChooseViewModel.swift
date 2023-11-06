//
//  ChooseViewModel.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/4/23.
//

import Foundation

@MainActor
class ChooseViewModel: ObservableObject {
    private var tabLabels = [
        "Busywork",
        "Charity",
        "Cooking",
        "DIY",
        "Education",
        "Music",
        "Recreational",
        "Relaxation",
        "Social",
    ]
    private (set) var tabItems = [TabItem]()
    private (set) var participantLabels = [
        "Any",
        "1",
        "2",
        "3",
        "4",
    ]
    private (set) var costLabels = [
        "Any",
        "Free",
        "Cheap",
        "Moderate",
        "Expensive",
    ]

    @Published private (set) var curSelection: Int = 0
    @Published private (set) var curParticipants: String
    @Published private (set) var curCost: String
    
    init() {
        for label in tabLabels {
            tabItems.append(TabItem(label: label, selected: false))
        }
        tabItems[0].selected = true
        curParticipants = participantLabels[0]
        curCost = costLabels[0]
    }

    func changeTabSelection(index: Int) {
        if (index != curSelection) {
            tabItems[curSelection].selected = false
            tabItems[index].selected = true
            curSelection = index
        }
    }
    
    func onParticipantsChanged(participants: String) {
        curParticipants = participants
    }
    
    func onCostChanged(cost: String) {
        curCost = cost
    }
}
