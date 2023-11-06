//
//  TabItem.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/3/23.
//

import SwiftUI

struct TabItem: View {
    let label: String
    var selected: Bool = false
    
    var body: some View {
        VStack {
            Text(label)
                .foregroundStyle(Color("Colors/TextWhite"))
            SelectionIndicator(visible: selected)
        }
        .frame(width: 100)
    }
}

#Preview {
    TabItem(label: "Recreational", selected: true)
}
