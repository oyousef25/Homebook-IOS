//
//  Media.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-11-17.
//

import Foundation

/*
    We will use this struct to retrieve the imageU url using the media array
 */
struct Media: Codable{
    var mediaURL: String?
    
    /*
     MARK: Coding Keys
     We will use this to match our variables with the API's values
     */
    enum CodingKeys: String, CodingKey{
        case mediaURL = "MediaURL"
    }
}


