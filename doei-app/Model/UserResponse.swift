//
//  UserResponse.swift
//  doei-app
//
//  Created by Max Mendes on 17/05/21.
//

import Foundation


struct UserResponse: Codable {
    var user: User?
    var token: String?
}
