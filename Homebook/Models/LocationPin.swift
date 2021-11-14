//
//  LocationPin.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-13.
//

import Foundation
import MapKit

/**
    This will be used to place a pin of the location on the MapView
 */

class LocationPin: NSObject, MKAnnotation{
    
    //MARK: Properties
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    /*
        MARK: Class initializer
     */
    init(title: String, subTitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subTitle
        self.coordinate = coordinate
    }
}
