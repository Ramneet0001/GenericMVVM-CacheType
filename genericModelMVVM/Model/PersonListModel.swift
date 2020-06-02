//
//  PersonListModel.swift
//  genericModelMVVM
//
//  Created by Ramneet on 01/06/20.
//  Copyright © 2020 abc. All rights reserved.
//

//   let personList = try? newJSONDecoder().decode(PersonList.self, from: jsonData)

import Foundation

// MARK: - PersonList
struct PersonListModel: Codable {
    let totalIndex, currentIndex, indexValue: Int
    var list: [List]
}

// MARK: - List
struct List: Codable {
    let imgURL, name, firstName, lastName: String
    let age: Int
    let email: String
    let mobile: Int
    let address, contact: String

    enum CodingKeys: String, CodingKey {
        case imgURL = "imgUrl"
        case name
        case firstName = "FirstName"
        case lastName = "LastName"
        case age = "Age"
        case email = "Email"
        case mobile = "Mobile"
        case address = "Address"
        case contact = "Contact"
    }
}
