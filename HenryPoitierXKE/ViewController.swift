//
//  ViewController.swift
//  HenryPoitierXKE
//
//  Created by Simone Civetta on 09/06/2017.
//  Copyright © 2017 Xebia IT Architects. All rights reserved.
//

import UIKit
import Alamofire
import UnboxedAlamofire

class ViewController: UICollectionViewController {

    private var books = [Book]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func getBooks() {
        Alamofire.request("http://henri-potier.xebia.fr/books/")
            .responseArray { (response: DataResponse<[Book]>) in
                //Swift 2
                guard let books = response.result.value else {
                    return
                }
                self.books = books
        }
    }

}

