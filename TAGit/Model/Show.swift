//
//  Match.swift
//  MondaysAtSix
//
//  Created by Macmini on 3/19/19.
//  Copyright © 2019 Onur Erdemol. All rights reserved.
//

import Foundation
import ObjectMapper

class Show: BaseObject{
    var title: String?
    var network: String?
    var category: String?
    var ratings: CGFloat?
    var image: String?
    var gdescription: String?
    var gwhere: String?
    var gtitle: String?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        title           <- map["title"]
        network         <- map["network"]
        category        <- map["category"]
        ratings         <- map["ratings"]
        image           <- map["image"]
        gdescription    <- map["gdescription"]
        gwhere    <- map["gwhere"]
        gtitle    <- map["gtitle"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let object = model as? Show else {
            return
        }
        
        title       = object.title      ?? title
        network     = object.network    ?? network
        category    = object.category   ?? category
        ratings     = object.ratings    ?? ratings
        image       = object.image      ?? image
        gdescription  = object.gdescription      ?? gdescription
        gwhere       = object.gwhere      ?? gwhere
        gtitle       = object.gtitle      ?? gtitle
    }
}

class ShowViewModel {
    static func description(show: Show?) -> String? {
        var result = show?.category
        if result == nil {
            return show?.network
        }
        else {
            if let network = show?.network {
                result = result! + "|" + network
            }
            return result
        }
    }
}

//For Sample Data
let showJSON: String =
"""
[
{
"id": 1,
"title": "Top & Skirt Set",
"network": "ABC",
"category": "THE BACHELOR",
"ratings": 4.5,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://amytaylorcollection.com/wp-content/uploads/2018/11/Screen-Shot-2019-02-19-at-12.41.15-pm-600x640.png"
},
{
"id": 2,
"title": "Plaid Skirt",
"network": "CWTV",
"category": "RIVERDALE",
"ratings": 4.9,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://66.media.tumblr.com/51ab355b5d8caa3f0d03aabbbc94ca6d/tumblr_p5hrhl3oku1v8bycso1_1280.png"
},
{
"id": 3,
"title": "Suit Jacket",
"network": "USA NETWORK",
"category": "SUITS",
"ratings": 3.5,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://pmctvline2.files.wordpress.com/2019/01/suits-renewed.jpg?w=620"
},
{
"id": 4,
"title": "Printed Mini Skirt",
"network": "NBC",
"category": "THE VOICE",
"ratings": 4.5,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://s.yimg.com/lo/api/res/1.2/x1hSqnBuIcbdC_vFsBMJag--/YXBwaWQ9YXBlY21lZGlhO3NtPTE7dz00Njg7aD01ODg-/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2019-06/8f2b8760-9195-11e9-a7fd-9e4adb55877d"
},
{
"id": 5,
"title": "Top & Skirt Set",
"network": "ABC",
"category": "THE BACHELOR",
"ratings": 4.5,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://amytaylorcollection.com/wp-content/uploads/2018/11/Screen-Shot-2019-02-19-at-12.41.15-pm-600x640.png"
},
{
"id": 6,
"title": "Plaid Skirt",
"network": "CWTV",
"category": "RIVERDALE",
"ratings": 4.9,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://66.media.tumblr.com/51ab355b5d8caa3f0d03aabbbc94ca6d/tumblr_p5hrhl3oku1v8bycso1_1280.png"
},
{
"id": 7,
"title": "Suit Jacket",
"network": "USA NETWORK",
"category": "SUITS",
"ratings": 3.5,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://pmctvline2.files.wordpress.com/2019/01/suits-renewed.jpg?w=620"
},
{
"id": 8,
"title": "Printed Mini Skirt",
"network": "NBC",
"category": "THE VOICE",
"ratings": 4.5,
"gdescription" : "The Aria top is the best essential for any girls wardrobe and can be worn to any event or just daily.",
"gtitle" : "Aria top & high waisted gem skirt",
"gwhere" : "from Amy Tailor Collection",
"image": "https://s.yimg.com/lo/api/res/1.2/x1hSqnBuIcbdC_vFsBMJag--/YXBwaWQ9YXBlY21lZGlhO3NtPTE7dz00Njg7aD01ODg-/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2019-06/8f2b8760-9195-11e9-a7fd-9e4adb55877d"
}
]
"""

extension Show {
    static func samples() -> [Show]? {
        let mapper = Mapper<Show>()
        return mapper.mapArray(JSONString: showJSON)
    }
}
