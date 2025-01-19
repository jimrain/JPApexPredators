//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Jim Rainville on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText: String = ""
    @State var alphabetical = false
    
    var filteredDinos: [ApexPredator] {
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        // NavigationStack is like a zstack but with nav features. 
        NavigationStack {
            // List is like a foreach but has some nice features like scrolling.
            List(filteredDinos) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                    
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
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
