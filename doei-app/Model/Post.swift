//
//  Post.swift
//  doei-app
//
//  Created by Max Mendes on 13/04/21.
//

import Foundation

struct Post: Codable {
    var _id: String?
    var title: String?
    var description: String?
    var location: String?
    var state: String?
    var img: String?
    var createdAt: String?
    var user: User?
}
