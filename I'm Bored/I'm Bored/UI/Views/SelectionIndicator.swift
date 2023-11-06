//
//  SelectionIndicator.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/3/23.
//

import SwiftUI

struct SelectionIndicator: View {
    var visible: Bool
    
    var body: some View {
        Rectangle()
            .fill(visible ? .brown : .clear)
            .frame(height: 8)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
    SelectionIndicator(visible: true)
}
