//
//  APIManager.swift
//  GeographicAtlas
//
//  Created by Aidos on 16.05.2023.
//

import Foundation

struct Constants {
    static let baseURL = "https://restcountries.com/v3.1"
}

enum APIError: Error {
    case failedToGetData
}

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func getAllCountries(completion: @escaping (Result<[CountryElement], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/all") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let countries = try decoder.decode([CountryElement].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getCountries(by continent: Continent, completion: @escaping (Result<[CountryElement], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/all") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let countries = try decoder.decode([CountryElement].self, from: data)
                let filteredCountries = countries.filter { $0.continents.contains(continent) }
                completion(.success(filteredCountries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func getCountry(by counrtyCode: String, completion: @escaping (Result<[CountryElement], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/alpha/\(counrtyCode)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let country = try decoder.decode([CountryElement].self, from: data)
                completion(.success(country))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


