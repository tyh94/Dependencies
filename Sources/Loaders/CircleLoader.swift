//
//  CircleLoader.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 13.06.2025.
//

import SwiftUI

public struct CircleLoader: View {
    public let color: Color
    
    public init(color: Color) {
        self.color = color
    }
    
    @State private var angle: Double = 0.0
    
    public var body: some View {
        Circle()
            .trim(from: 0.1,to: 1.0)
            .stroke(style: StrokeStyle(lineWidth: 8,lineCap: .round,lineJoin: .round))
            .foregroundStyle(color)
            .rotationEffect(Angle(degrees: angle))
            .onAppear{
                withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                    angle = 360
                }
            }
    }
}

@available(iOS 17.0, *)
#Preview {
    CircleLoader(color: .orange)
}
