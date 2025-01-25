//
//  Predators.swift
//  JPApexPredators
//
//  Created by Jim Rainville on 1/18/25.
//
import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    var allMovies: [String] = ["All"]
    
    init() {
        decodeApexPredatorData()
        getAllMovies()
    }
    
    func getAllMovies() {
        for predator in allApexPredators {
            for movie in predator.movies {
                if !allMovies.contains(movie) {
                    allMovies.append(movie)
                }
            }
        }
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                // JSON is snake case but our struct uses camel case.
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: APType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
    
    // Important to filter movies after filtering types because this funtion operates on the
    // apexPredators list mofified by the type filter. 
    func filter(by movie: String) {
        if movie != "All" {
            apexPredators = apexPredators.filter { predator in
                predator.movies.contains(movie)
            }
        }
    }
}
