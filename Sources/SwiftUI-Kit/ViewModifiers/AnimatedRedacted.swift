//
//  AnimatedRedacted.swift
//  
//
//  Created by Alexander Sharko on 13.02.2023.
//

import SwiftUI

public struct AnimatedRedactedModifier: ViewModifier {
    public var isActive: Bool
    public var backgroundColor: Color
    public var overlayGradient: LinearGradient
    
    @State private var animated: Bool
    
    public init(
        isActive: Bool,
        backgroundColor: Color = .gray,
        overlayGradient: LinearGradient = .init(colors: [.clear, .gray, .clear], startPoint: .leading, endPoint: .trailing)
    ) {
        self.isActive = isActive
        self.backgroundColor = backgroundColor
        self.overlayGradient = overlayGradient
        self.animated = false
    }
    
    public func body(content: Content) -> some View {
        content
        .if(isActive) {
            $0.overlay(
                ZStack {
                    backgroundColor
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let offset = geometry.size.width * 2.5
                        let scale = max((width / height), (height / width))
                        overlayGradient
                            .offset(x: animated ? offset : -offset)
                            .scaleEffect(scale)
                            .rotationEffect(.init(degrees: -45))
                            .animation(
                                .linear(duration: 1.5).repeatForever(autoreverses: false),
                                value: animated
                            )
                            .onAppear { animated = true }
                    }
                }
                .mask(Rectangle())
            )
        }
    }
}

struct AnimatedRedactedModifier_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .frame(width: 200, height: 200)
            .modifier(AnimatedRedactedModifier(isActive: true))
    }
}
