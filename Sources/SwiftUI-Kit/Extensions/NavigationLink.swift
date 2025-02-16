//
//  NavigationLink.swift
//  SwiftUIKit
//
//  Created by Max Kuznetsov on 08.12.2020.
//

import SwiftUI

public extension NavigationLink where Label == EmptyView {
    init(destination: Destination, isActive: Binding<Bool>) {
        self.init(destination: destination, isActive: isActive) { EmptyView() }
    }
    
    init(isActive: Binding<Bool>, @ViewBuilder destination: @escaping () -> Destination) {
        self.init(destination: destination(), isActive: isActive) { EmptyView() }
    }
}
