//
//  Book.swift
//  HenryPoitierXKE
//
//  Created by Simone Civetta on 09/06/2017.
//  Copyright © 2017 Xebia IT Architects. All rights reserved.
//

import Foundation
import Unbox

struct Book: Unboxable {
    let cover: String
    let title: String
    let price: Float
    
    init(unboxer: Unboxer) throws {
        self.cover = try unboxer.unbox(key: "cover")
        self.title = try unboxer.unbox(key: "title")
        self.price = try unboxer.unbox(key: "price")
    }
}
