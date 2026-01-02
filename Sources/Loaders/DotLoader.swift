//
//  DotLoader.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 12.06.2025.
//

import SwiftUI

public struct DotLoader: View {
    struct Particle: Identifiable {
        let id: UUID
        let angle: Double
    }
    
    let particleCount: Int
    let radius: CGFloat
    let color: Color
    
    @State private var particles:[Particle] = []
    
    public init(
        particleCount: Int = 8,
        radius: CGFloat = 20.0,
        color: Color = .orange
    ) {
        self.particleCount = particleCount
        self.radius = radius
        self.color = color
    }
    
    public var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .frame(width: 10, height: 10)
                    .offset(
                        x: radius * CGFloat(cos(particle.angle * .pi/180)),
                        y: radius * CGFloat(sin(particle.angle * .pi/180)))
                    .foregroundStyle(color)
            }
        }
        .onAppear {
            particles = (0..<particleCount).map{ index in
                Particle(id: UUID(), angle: Double(index) * (360.0 / Double(particleCount)))
            }
            
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                particles = particles.map{ particle in
                    Particle(id: particle.id, angle: particle.angle - 600.0)
                }
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    DotLoader()
}
