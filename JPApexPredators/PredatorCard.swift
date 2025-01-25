//
//  PredatorCard.swift
//  JPApexPredators
//
//  Created by Jim Rainville on 1/24/25.
//

import SwiftUI

struct PredatorCard: View {
    @Environment(\.dismiss) var dismiss
    let predator: ApexPredator

    var body: some View {
        VStack{
            HStack{
                Image(predator.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading){
                    Text(predator.name)
                        .font(.title)
                }
            }
            Link(predator.link, destination: URL(string: predator.link)!)
                .font(.caption)
                .foregroundStyle(.blue)
            
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
    PredatorCard(predator: predator)
}
