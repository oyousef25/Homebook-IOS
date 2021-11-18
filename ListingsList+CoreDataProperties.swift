//
//  ListingsList+CoreDataProperties.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-17.
//
//

import Foundation
import CoreData


extension ListingsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListingsList> {
        return NSFetchRequest<ListingsList>(entityName: "ListingsList")
    }

    @NSManaged public var listPrice: Int32
    @NSManaged public var bathroomsTotalInteger: Int32
    @NSManaged public var bedroomsTotal: Int32
    @NSManaged public var streetNumber: String?
    @NSManaged public var streetName: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var stateOrProvince: String?
    @NSManaged public var yearBuilt: Int32
    @NSManaged public var propertySubType: String?
    @NSManaged public var listAgentMlsId: String?
    @NSManaged public var onMarketDate: String?
    @NSManaged public var livingArea: Int32
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var mediaURL: String?

}

extension ListingsList : Identifiable {

}
