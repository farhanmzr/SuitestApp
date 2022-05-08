//
//  User.swift
//  SuitestApp
//
//  Created by Farhan Mazario on 29/04/22.
//

import Foundation
import UIKit

struct User: Codable{
    
    let data: [UserData]
    
    struct UserData: Codable {
        let id: Int
        let email: String
        let first_name: String
        let last_name: String
        let avatar: String
    }
    
}
