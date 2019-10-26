//
//  TVShow.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/8.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import Foundation
import ObjectMapper
class TVShow: BaseObject{
    var title: String?
    var image: String?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        title           <- map["title"]
        image           <- map["image"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let object = model as? Show else {
            return
        }
        
        title       = object.title      ?? title
        image       = object.image      ?? image
    }
}
//For Sample Data
let tvShowJSON: String =
"""
[
{
"id": 1,
"title": "Top & Skirt Set",
"image": "https://i.imgur.com/rZ4RvlQ.png"
},
{
"id": 2,
"title": "Plaid Skirt",
"image": "https://i.imgur.com/fiXqsNG.png"
},
{
"id": 3,
"title": "Suit Jacket",
"image": "https://i.imgur.com/JYe1j1p.png"
}
]
"""

extension TVShow {
    static func samples() -> [TVShow]? {
        let mapper = Mapper<TVShow>()
        return mapper.mapArray(JSONString: tvShowJSON)
    }
}

