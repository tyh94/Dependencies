//
//  BounceLoader.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 13.06.2025.
//

import SwiftUI

public struct BounceLoader: View {
    struct DotView: View {
        let color: Color
        let dotSize: CGFloat
        
        var body: some View {
            Circle()
                .frame(width: dotSize,height: dotSize)
                .foregroundStyle(color)
        }
    }
    
    // MARK: - Properties
    @State private var offsetY1: CGFloat = 0.0
    @State private var offsetY2: CGFloat = 0.0
    @State private var offsetY3: CGFloat = 0.0
    let color: Color
    let dotSize: CGFloat
    let bounceDistance: CGFloat
    let animationDuration: Double
    let delayBetweenDots: Double
    
    init(
        color: Color = .orange,
        dotSize: CGFloat = 20.0,
        bounceDistance: CGFloat = 20.0,
        animationDuration: Double = 0.5,
        delayBetweenDots: Double = 0.2
    ) {
        self.color = color
        self.dotSize = dotSize
        self.bounceDistance = bounceDistance
        self.animationDuration = animationDuration
        self.delayBetweenDots = delayBetweenDots
    }
    
    public var body: some View {
        HStack(spacing: 20, content: {
            DotView(color: color, dotSize: dotSize)
                .offset(y:offsetY1)
            DotView(color: color, dotSize: dotSize)
                .offset(y:offsetY2)
            DotView(color: color, dotSize: dotSize)
                .offset(y:offsetY3)
        })
        .onAppear(perform: {
            animateDots()
        })
    }
    
    private func animateDots(){
        withAnimation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
            offsetY1 = bounceDistance
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayBetweenDots, execute: {
            withAnimation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
                offsetY2 = bounceDistance
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 * delayBetweenDots, execute: {
            withAnimation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
                offsetY3 = bounceDistance
            }
        })
    }
}

@available(iOS 17.0, *)
#Preview {
    BounceLoader(color: .orange)
}
