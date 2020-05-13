//
//  Model.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation

// MARK: - Temperature
struct Article: Codable {
    var id, createdAt, content: String?
    var comments, likes: Int?
    var media: [Media]?
    var user: [User]?
}

// MARK: - Media
struct Media: Codable {
    var id, blogID, createdAt: String?
    var image: String?
    var title: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, image, title, url
    }
}

// MARK: - User
struct User: Codable {
    var id, blogID, createdAt, name: String?
    var avatar: String?
    var lastname, city, designation, about: String?
    
    var fullName : String?{
        if let fName = name, let lName = lastname{
            return fName + " " + lName
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, name, avatar, lastname, city, designation, about
    }
}

typealias Articles = [Article]
