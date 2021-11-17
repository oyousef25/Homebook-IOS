//
//  Listing.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-10-27.
//

import Foundation

struct Listings: Codable{
    var value: [Listing]
}

struct Listing: Codable{
    //MARK: Properties
    var listingId: UUID?
    
    /*
        Home page properties
     */
    var media: [Media]?
    var listPrice: Int?
    var bathroomsTotalInteger: Int?
    var bedroomsTotal: Int?
    
    var streetNumber: String?
    var streetName: String?
    
    var city: String?
    var stateOrProvince: String?
    var country: String?
    
    /*
        details page extra properties
     */
    var yearBuilt: Int?
    var propertySubType: String?
    var listAgentMlsId: String?
    var onMarketDate: String?
    var livingArea: Int?
    
    
    var longitude: Double?
    var latitude: Double?
    
    
    /*
        Encoding and Decoding methods to conform to the protocols
     */
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            listPrice = try container.decode(Int.self, forKey: .listPrice)
            bathroomsTotalInteger = try container.decode(Int.self, forKey: .bathroomsTotalInteger)
            bedroomsTotal = try container.decode(Int.self, forKey: .bedroomsTotal)
            
            streetNumber = try container.decode(String.self, forKey: .streetNumber)
            streetName = try container.decode(String.self, forKey: .streetName)
            
            city = try container.decode(String.self, forKey: .city)
            stateOrProvince = try container.decode(String.self, forKey: .stateOrProvince)
            country = try container.decode(String.self, forKey: .country)
            
            yearBuilt = try container.decode(Int.self, forKey: .yearBuilt)
            propertySubType = try container.decode(String.self, forKey: .propertySubType)
            listAgentMlsId = try container.decode(String.self, forKey: .listAgentMlsId)
            onMarketDate = try container.decode(String.self, forKey: .onMarketDate)
            livingArea = try container.decode(Int.self, forKey: .livingArea)
                
            longitude = try container.decode(Double.self, forKey: .longitude)
            latitude = try container.decode(Double.self, forKey: .latitude)
            
            media = try container.decode([Media].self, forKey: .media)
            
        }catch{
            streetNumber = "Not found"
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(listPrice, forKey: .listPrice)
        try container.encode(bathroomsTotalInteger, forKey: .bathroomsTotalInteger)
        try container.encode(bedroomsTotal, forKey: .bedroomsTotal)
        
        try container.encode(streetNumber, forKey: .streetNumber)
        try container.encode(streetName, forKey: .streetName)
        
        try container.encode(city, forKey: .city)
        try container.encode(stateOrProvince, forKey: .stateOrProvince)
        try container.encode(country, forKey: .country)
        
        try container.encode(yearBuilt, forKey: .yearBuilt)
        try container.encode(propertySubType, forKey: .propertySubType)
        try container.encode(listAgentMlsId, forKey: .listAgentMlsId)
        try container.encode(onMarketDate, forKey: .onMarketDate)
        try container.encode(livingArea, forKey: .livingArea)
        
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
        
        try container.encode(media, forKey: .media)
    }
    
    /*
     MARK: Coding Keys
     We will use this to match our variables with the API's values
     */
    enum CodingKeys: String, CodingKey{
        case media = "Media"
        case listingID = "ListingID"
        case listPrice = "ListPrice"
        case bathroomsTotalInteger = "BathroomsTotalInteger"
        case bedroomsTotal = "BedroomsTotal"
        
        case streetNumber = "StreetNumber"
        case streetName = "StreetName"
        
        case city = "City"
        case stateOrProvince = "StateOrProvince"
        case country = "Country"
        
        /*
            details page extra properties
         */
        case yearBuilt = "YearBuilt"
        case propertySubType = "PropertySubType"
        case listAgentMlsId = "ListAgentMlsId"
        case onMarketDate = "OnMarketDate"
        case livingArea = "LivingArea"
        case longitude = "Longitude"
        case latitude = "Latitude"
    }
}
