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
    var offers = [Offers]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDiscount(isbns: "t")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    private func getDiscount(isbns: String) {
        Alamofire.request("http://henri-potier.xebia.fr/books/c8fabf68-8374-48fe-a7ea-a00ccd07afff,c8fabf68-8374-48fe-a7ea-a00ccd07afff/commercialOffers")
            .responseArray { (response: DataResponse<[Offers]>) in
                //Swift 2
                
                guard let offers = response.result.value else {
                    return
                }
                self.offers = offers
                print(offers)
        }
    }
    
    private func getDiscountBis(isbns: String){
        Alamofire.request("http://henri-potier.xebia.fr/books/").responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }

}
