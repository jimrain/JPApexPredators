//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Jim Rainville on 1/21/25.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    @State var position: MapCameraPosition
    @State var satellite = false
    @State var showInfoCard: Bool = false
    
    let predators = Predators()
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                        .onTapGesture {
                            showInfoCard.toggle()
                        }
                        .sheet(isPresented: $showInfoCard) {
                            PredatorCard(predator: predator)
                                .frame(maxWidth: 300, maxHeight: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color(white: 0.7), radius: 20)
                                .presentationBackground {
                                    Rectangle()
                                        .fill(.ultraThinMaterial)
                                        .background(.black.opacity(0.2))
                                }
                        }
                }
                
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
        
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(
        centerCoordinate: Predators().apexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80)
    ))
    .preferredColorScheme(.dark)
}
