//
//  AppModel.swift
//  
//
//  Created by Infosys on 1/16/19.
//

import Foundation

struct AppModel : Codable{
    var artistName : String
    var description : String
    var fileSizeBytes : String
    var genres : [String]
    var trackCensoredName : String
    var artworkUrl60 : String
    var artworkUrl100 : String
    var screenshotUrls : [String]
}
