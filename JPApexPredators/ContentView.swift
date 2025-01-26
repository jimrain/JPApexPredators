//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Jim Rainville on 1/18/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText: String = ""
    @State var alphabetical = false
    @State var currentTypeSelection = APType.all
    @State var currentMovieSelection = "All"
    
    var filteredDinos: [ApexPredator] {
        predators.filterOutDeleted()
        predators.filter(by: currentTypeSelection)
        predators.filter(by: currentMovieSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        // NavigationStack is like a zstack but with nav features.
        // let _ = print("\(predators.allMovies)")
        NavigationStack {
            // List is like a foreach but has some nice features like scrolling.
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(
                        MapCamera(
                            centerCoordinate: predator.location,
                            distance: 30000
                        )))
                    
                } label: {
                    
                    
                    HStack {
                        // Dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading ) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                            // Change from a rect to an oval
                                .clipShape(Capsule())
                            
                            
                        }
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        withAnimation(.linear(duration: 0.4)) {
                            predators.removePredator(id: predator.id)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled(true)
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                        
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Text("Type")
                            .font(.largeTitle)
                            .background(.white)
                        Picker("Filter", selection: $currentTypeSelection.animation()) {
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                        Text("Movies")
                            .font(.largeTitle)
                            .background(.white)
                        Picker("Filter", selection: $currentMovieSelection) {
                            ForEach(predators.allMovies, id: \.self) { movie in
                                Label(movie, systemImage: "film")
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
