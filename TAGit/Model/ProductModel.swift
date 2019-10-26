//
//  ProductModel.swift
//  TAGit
//
//  Created by Liu Jie on 2019/8/1.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductModel: BaseObject{
    var title: String?
    var name: String?
    var networkId: Int?
    var description: String?
    var url: String?
    var keywords: String?
    var price: CGFloat?
    var image: String?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        title           <- map["title"]
        name         <- map["name"]
        networkId        <- (map["network_id"], IntTransform.shared)
        description         <- map["description"]
        image           <- map["image"]
        url    <- map["url"]
        keywords    <- map["keywords"]
        price    <- map["price"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let object = model as? ProductModel else {
            return
        }
        
        title       = object.title      ?? title
        name    = object.name   ?? name
        networkId     = object.networkId
        image       = object.image      ?? image
        description  = object.description      ?? description
        url       = object.url      ?? url
        keywords       = object.keywords      ?? keywords
        price   = object.price          ?? price
    }
}
