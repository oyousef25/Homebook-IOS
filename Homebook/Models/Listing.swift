//
//  Listing.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-10-27.
//

import Foundation

class Listing{
    //MARK: Properties
    var id: UUID?
    var mlsNumber: Array<Any>?
    var brokerage: String?
    var listDate: String?
    
    var map: Array<Any>?
    var area: Array<Any>?
    var city: Array<Any>?
    
    var streetNumber: String?
    var streetName: String?
    
    var maxBaths: Int?
    var maxBeds: Int?
    var maxSqft: Int?
    var maxPrice: Int?
    
}
