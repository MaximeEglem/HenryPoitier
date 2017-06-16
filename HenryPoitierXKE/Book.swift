//
//  Book.swift
//  HenryPoitierXKE
//
//  Created by Maxime Eglem on 15/06/2017.
//  Copyright © 2017 Xebia IT Architects. All rights reserved.
//

import Foundation
import Unbox

struct Book {
    let isbn, title, cover: String
    let price: Double
    let synopsis: [String]

}

extension Book: Unboxable {
    init(unboxer: Unboxer) throws {
        self.isbn = try unboxer.unbox(key: "isbn")
        self.title = try unboxer.unbox(key: "title")
        self.price = try unboxer.unbox(key: "price")
        self.cover = try unboxer.unbox(key: "cover")
        self.synopsis = try unboxer.unbox(key: "synopsis")
    }
}

struct BookOrder {
    let title : String
    let price : Double
    var number : Int
    
    init(book: Book) {
        title = book.title
        price = book.price
        number = 1
    }
}
