//
//  CategoryModel.swift
//  TAGit
//
//  Created by Liu Jie on 2019/8/1.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryModel: BaseObject{
    var title: String?
    var name: String?
    var networkId: Int?
    var logo: String?
    var image: String?
    var products: [ProductModel]?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        title           <- map["title"]
        name         <- map["name"]
        networkId        <- (map["network_id"], IntTransform.shared)
        logo         <- map["logo"]
        image           <- map["image"]
        products    <- map["products"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let object = model as? CategoryModel else {
            return
        }
        
        title       = object.title      ?? title
        networkId     = object.networkId
        name     = object.name    ?? name
        image       = object.image      ?? image
        logo  = object.logo      ?? logo
        products = object.products  ?? products
    }
}
