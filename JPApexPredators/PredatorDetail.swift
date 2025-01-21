//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Jim Rainville on 1/20/25.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    var body: some View {
        // Geometry gives me the exact size of the current device
        // Scroll view is like a vstack except views start at the top instead
        // of the middle
        GeometryReader { geo in
            ScrollView {
                ZStack (alignment: .bottomTrailing) {
                    // Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0),
                                Gradient.Stop(color: .black, location: 0.8)
                                /*
                                 // These are percentages so it starts purple, changes to red 33% down etc.
                                Gradient.Stop(color: .purple, location: 0),
                                Gradient.Stop(color: .red, location: 0.33),
                                Gradient.Stop(color: .blue, location: 0.66),
                                Gradient.Stop(color: .green, location: 1),
                                 */
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    
                    // Dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3.75)
                        // Flips the image on the x axis.
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y:20)
                }
                
                VStack(alignment: .leading) {
                    
                    // Dino name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    
                    // Current location
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                    Map(position: $position) {
                        Annotation(predator.name, coordinate: predator.location) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .symbolEffect(.pulse)
                            
                        }
                        .annotationTitles(.hidden)
                    }
                    .frame(height: 125)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "greaterthan")
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing, 5)
                    }
                    .overlay(alignment: .topLeading) {
                        Text("Current Location")
                            .padding([.leading, .bottom])
                            .background(.black.opacity(0.33))
                            .clipShape(.rect(bottomTrailingRadius: 15))
                            
                    }
                    .clipShape(.rect(cornerRadius: 15))
                }
                    
                    // Appears in
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
                    // Since we can't add "identifiable" to the string class we can pass self as the id (since we know the strings are unique)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("• " + movie)
                            .font(.subheadline)
                        
                        //
                    }
                    
                    // Movie Moments
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                            
                    }
                    
                    // Link to webpage
                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                        
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
            .toolbarBackground(.automatic)
        }
    }
}

#Preview {
    let predator = Predators().apexPredators[2]
    NavigationStack {
        PredatorDetail(predator: predator,
                       position: .camera(
                        MapCamera(
                            centerCoordinate: predator.location,
                            distance: 30000
                        )))
        .preferredColorScheme(.dark)
    }
}
