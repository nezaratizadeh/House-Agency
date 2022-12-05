//
//  House.swift
//  House-Agency
//
//  Created by Leila Nezaratizadeh on 03/11/2022.
//

import Foundation


class House : Codable , ObservableObject{
    var id: Int
    var image: String
    var price: Int
    var bedrooms: Int
    var bathrooms: Int
    var size: Int
    var description: String
    var zip: String
    var city: String
    var latitude: Int
    var longitude: Int
    var createdDate: String
    
    
    init(id:Int = 1 ,image:String = "1",price:Int = 1,bedrooms: Int=1,bathrooms: Int=1,size: Int=1,description: String="De woning is gelegen in een Rijksmonument aan het begin van de Spuistraat net om de hoek bij het oude Kattegat en de Koepelkerk. De ligging van het pand is ideaal. Op loopafstand van het Centraal Station maar ook van o.a. de Kalverstraat en Nieuwendijk met een diversiteit aan winkels. En om de hoek treft u een supermarkt waar u terecht kunt voor de dagelijkse boodschappen.",zip: String="1"
         ,city: String="1",latitude: Int=1,longitude: Int=1,createdDate: String="1"){
        self.id = id
        self.image = image
        self.price = price
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.size = size
        self.description = description
        self.zip = zip
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.createdDate = createdDate
        
    }
    
}



extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        lhs === rhs
    }
    
}

extension House: Hashable,Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
