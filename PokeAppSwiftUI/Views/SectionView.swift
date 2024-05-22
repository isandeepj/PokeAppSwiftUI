//
//  SectionView.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            content
        }
    }
}
