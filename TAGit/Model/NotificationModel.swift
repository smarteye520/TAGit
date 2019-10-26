//
//  NotificationModel.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/10.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import Foundation
import ObjectMapper

class NotificationModel: BaseObject{
    var message: String?
    var image: String?
    var isRead: Bool = false
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        message           <- map["message"]
        image           <- map["image"]
        isRead          <- map["is_read"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let object = model as? NotificationModel else {
            return
        }
        
        message       = object.message      ?? message
        image       = object.image      ?? image
        isRead      = object.isRead
    }
}
let inboxJSON: String =
"""
[
{
"id": 1,
"is_read": false,
"message": "Trend Alert! Everyone’s raving about Kim K’s party outfit. Check it out!",
"image": "https://amytaylorcollection.com/wp-content/uploads/2018/11/Screen-Shot-2019-02-19-at-12.41.15-pm-600x640.png"
},
{
"id": 2,
"is_read": true,
"message": "New fashion items added to ‘Gossip Girl’!",
"image": "https://pmctvline2.files.wordpress.com/2019/01/suits-renewed.jpg?w=620"
},
{
"id": 3,
"is_read": true,
"message": "Spring into the new season with the hottest accessories!",
"image": "https://66.media.tumblr.com/51ab355b5d8caa3f0d03aabbbc94ca6d/tumblr_p5hrhl3oku1v8bycso1_1280.png"
}
]
"""

extension NotificationModel {
    static func samples() -> [NotificationModel]? {
        let mapper = Mapper<NotificationModel>()
        return mapper.mapArray(JSONString: inboxJSON)
    }
}
