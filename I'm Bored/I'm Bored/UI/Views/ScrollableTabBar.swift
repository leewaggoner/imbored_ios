//
//  ScrollableTabBar.swift
//  I'm Bored
//
//  Created by Lee Waggoner on 11/3/23.
//

import SwiftUI

struct ScrollableTabBar: View {
    var items: [TabItem]
    var selected: Int
    var onChange: (Int) -> Void
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items.indices, id: \.self) { index in
                        items[index]
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    onChange(index)
                                }
                            }
                    }
                }
            }
            .onChange(of: selected) {
                withAnimation {
                    scrollView.scrollTo(selected, anchor: .center)
                }
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
            .background(Color("Colors/Tertiary"))
            .background(.purple)
        }
    }
}

#Preview {
    @StateObject var viewModel = ChooseViewModel()
    return ScrollableTabBar(
        items: ChooseViewModel().tabItems,
        selected: viewModel.curSelection
    ) { newIndex in
        viewModel.changeTabSelection(index: newIndex)
    }
}

