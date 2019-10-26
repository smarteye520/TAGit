//
//  EpisodeModel.swift
//  TAGit
//
//  Created by Liu Jie on 2019/8/1.
//  Copyright © 2019 MajestykApps. All rights reserved.
//
import Foundation
import ObjectMapper

class EpisodeModel: BaseObject{
    var showId: Int?
    var showName: String?
    var title: String?
    var name: String?
    var season: String?
    var image: String?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        showId        <- (map["show_id"], IntTransform.shared)
        showName      <- map["show_name"]
        title           <- map["title"]
        name         <- map["name"]
        season         <- map["season"]
        image           <- map["image"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let object = model as? EpisodeModel else {
            return
        }
        showId = object.showId
        showName = object.showName ?? showName
        title       = object.title      ?? title
        name     = object.name    ?? name
        image       = object.image      ?? image
        season  = object.season      ?? season
    }
}

