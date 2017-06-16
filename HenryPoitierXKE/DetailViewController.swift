//
//  DetailViewController.swift
//  HenryPoitierXKE
//
//  Created by Maxime Eglem on 15/06/2017.
//  Copyright © 2017 Xebia IT Architects. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    var booksOrdered = [String : BookOrder]()
    var offers : Offers?
    var totalPrice : Double = 0
    @IBOutlet weak var Offer2: UILabel!
    @IBOutlet weak var Offer3: UILabel!
    @IBOutlet weak var Offer1: UILabel!
    @IBOutlet weak var bestDiscount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlIsbn : String = ""
        
        for (isbn, value) in booksOrdered {
            for _ in 1...value.number {
                urlIsbn += "\(isbn),"
            }
            totalPrice += value.price * Double(value.number)
        }
        urlIsbn = urlIsbn.substring(to: urlIsbn.index(before: urlIsbn.endIndex))
        getDiscount(isbns: urlIsbn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    private func getDiscount(isbns: String) {
        let url = "http://henri-potier.xebia.fr/books/\(isbns)/commercialOffers"
        Alamofire.request(url).responseObject { (response: DataResponse<Offers>) in
            
            guard let offers = response.result.value else {
                return
            }
            self.offers = offers

            self.bestDiscount.text = String(self.getBestDiscount())
        }
    }
    
    private func getBestDiscount() -> Double {
        
        var discount = [Double]()
        if (self.offers?.offers.count)!>=1 {
            discount.append(self.totalPrice * Double((self.offers?.offers[0].value)!) / 100)
        }
        if (self.offers?.offers.count)!>=2 {
            discount.append((self.offers?.offers[1].value)!)
        }
        if (self.offers?.offers.count)!>=3 {
            discount.append(Double(Int(self.totalPrice / 100)) * Double((self.offers?.offers[3].value)!))
        }
  
        return discount.max()!
    }
}
