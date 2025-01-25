//
//  PredatorImage.swift
//  JPApexPredators
//
//  Created by Jim Rainville on 1/23/25.
//

import SwiftUI

struct PredatorImage: View {
    @Environment(\.dismiss) var dismiss
    let predator: ApexPredator
    
    var body: some View {
        VStack {
            Image(predator.image)
                .resizable()
                .scaledToFit()
            
                .padding()
            
            // Spacer()
            
            Button("Done") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.brown.mix(with: .black, by: 0.2))
            .font(.largeTitle)
            .padding()
            // This overrides the forgroundSytle on the VStack
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    let predator = Predators().apexPredators[2]
    PredatorImage(predator: predator)
}
