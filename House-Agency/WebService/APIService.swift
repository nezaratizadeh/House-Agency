//
//  APIService.swift
//  House-Agency
//
//  Created by Leila Nezaratizadeh on 03/11/2022.
//

import Foundation

final class APIService {
    
    static let apiService = APIService()
    private init() {
        
    }
    
    func loadHouses(houses: HouseViewModel) {
        let url = Constants.baseURL.rawValue
        
        guard let url = URL(string: "\(url)") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Access-Key": "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                
                let decodedData = try JSONDecoder().decode([House].self,
                                                           from: prettyJsonData)
                DispatchQueue.main.async {
                    houses.houses = decodedData.sorted{
                        $0.price < $1.price
                    }
                }
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
        
    }
}
