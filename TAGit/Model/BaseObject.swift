//
//  BaseDataModel.swift
//  MondaysAtSix
//
//  Created by Onur Erdemol
//  Copyright © 2018 Onur Erdemol. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseObject: Mappable {
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    
    var stringId: String {
        guard let id = id else {
            return ""
        }
        return "\(id)"
    }
    
    init () {
        
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id             <- (map["id"], IntTransform.shared)
        createdAt      <- (map["created_at"], DateTransform.shared)
        updatedAt      <- (map["updated_at"], DateTransform.shared)
    }
    
    static func map<T: Mappable>(json: Any) -> T? {
        let mapper = Mapper<T>()
        return mapper.map(JSONObject: json)
    }
    
    func attach(_ model: BaseObject) {
        id          = model.id ?? id
        createdAt   = model.createdAt ?? createdAt
        updatedAt   = model.updatedAt ?? updatedAt
    }
}

extension BaseObject: Equatable {
    static func == (lhs: BaseObject, rhs: BaseObject) -> Bool {
        guard let lid = lhs.id, let rid = rhs.id else {
            return false
        }
        return lid == rid
    }
}
