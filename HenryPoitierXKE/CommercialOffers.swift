//
//  CommercialOffers.swift
//  HenryPoitierXKE
//
//  Created by Maxime Eglem on 15/06/2017.
//  Copyright © 2017 Xebia IT Architects. All rights reserved.
//

import Foundation
import Unbox

struct Offers {
    let offers: [Offer]
}

extension Offers: Unboxable {
    init(unboxer: Unboxer) throws {
        self.offers = try unboxer.unbox(key: "offers")
    }
}

struct Offer{
    let type: TypeOffer
    let value: Double
    let sliceValue: Double?
}

extension Offer: Unboxable {
    init(unboxer: Unboxer) throws {
        self.type = try unboxer.unbox(key: "type")
        self.value = try unboxer.unbox(key: "value")
        self.sliceValue = unboxer.unbox(key: "sliceValue")
    }
}

enum TypeOffer: String, UnboxableEnum {
    case percentage
    case minus
    case slice
}
