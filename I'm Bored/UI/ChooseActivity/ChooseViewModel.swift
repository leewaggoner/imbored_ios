//
//  ChooseViewModel.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/4/23.
//

import Foundation

@MainActor
class ChooseViewModel: ObservableObject {
    var pexelsClient: PexelsImages = PexelsImages()
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
    @Published private (set) var boredImage: BoredImage?
    @Published private (set) var errorMsg: String?
    
    init() {
        for label in tabLabels {
            tabItems.append(TabItem(label: label, selected: false))
        }
        tabItems[0].selected = true
        curParticipants = participantLabels[0]
        curCost = costLabels[0]
        fetchInitialImage()
    }
    
    func fetchInitialImage() {
        fetchImage(query: "Cleaning")
    }

    func changeTabSelection(index: Int) {
        if (index != curSelection) {
            tabItems[curSelection].selected = false
            tabItems[index].selected = true
            curSelection = index
            self.boredImage = BoredImage()
            fetchImage(query: tabLabels[index])
        }
    }
    
    func onParticipantsChanged(participants: String) {
        curParticipants = participants
    }
    
    func onCostChanged(cost: String) {
        curCost = cost
    }
    
    func getActivityUrl() -> String {
        var url = "https://www.boredapi.com/api/activity?type=\(tabLabels[curSelection].lowercased())"
        if !curParticipants.isEmpty {
            url += getParticipantsParam()
        }
        if !curCost.isEmpty {
            url += getCostParam()
        }
        return url
    }
    
    //TODO: Create a cache for BoredImages
    private func fetchImage(query: String) {
        pexelsClient.fetchImageUrl(query: query) { result in
            switch result {
                case .success(let newBoredImage):
                    self.boredImage = newBoredImage ?? BoredImage()
                case .failure(let error):
                    switch error {
                        case .ApiError: self.errorMsg = "Bored API Error."
                        case .NetworkError: self.errorMsg = "Network error."
                        case .Retry: self.fetchImage(query: "Cleaning") // No result. Retry with cleaning.
                    }
            }
        }
    }
    
    private func getParticipantsParam() -> String {
        return switch (curParticipants) {
            case "Any": ""
            default: "&participants=\(curParticipants)"
        }
    }

    private func getCostParam() -> String {
        return switch (curCost) {
            case "Free": "&price=0.0"
            case "Cheap": "&minprice=0.1&maxprice=0.3"
            case "Moderate": "&minprice=0.4&maxprice=0.7"
            case "Expensive": "&minprice=0.8&maxprice=1.0"
            default: ""
        }
    }
}
