//
//  API.swift
//  doei-app
//
//  Created by Max Mendes on 03/05/21.
//

import Foundation

extension Bundle {
    var api: String {
        return object(forInfoDictionaryKey: "api") as! String
    }
}

struct API {
    static let baseUrl = Bundle.main.api
}
