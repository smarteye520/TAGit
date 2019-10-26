//
//  CountryModel.swift
//  TAGit
//
//  Created by Liu Jie on 2019/7/12.
//  Copyright © 2019 MajestykApps. All rights reserved.
//

import Foundation
import ObjectMapper

class CountryModel: BaseObject{
    var name: String?
    var dial_code: String?
    var code: String?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        name           <- map["name"]
        dial_code           <- map["dial_code"]
        code          <- map["code"]
    }
    
    override func attach(_ model: BaseObject) {
        super.attach(model)
        guard let object = model as? CountryModel else {
            return
        }
        
        name       = object.name      ?? name
        dial_code       = object.dial_code      ?? dial_code
        code      = object.code ?? code
    }
}

var contryJson: String? = {
    if let path = Bundle.main.path(forResource: "countryCodes", ofType: "json") {
        do {
            let contents = try String(contentsOfFile: path)
            return contents
        } catch {
            return nil
        }
    }
    return nil
}()
extension CountryModel {
    static func countries() -> [CountryModel]? {
        let mapper = Mapper<CountryModel>()
        return mapper.mapArray(JSONString: contryJson ?? "")
    }
}
