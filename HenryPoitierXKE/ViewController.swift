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
    
    private func retrieve() {
        Alamofire.request("http://henri-potier.xebia.fr/books/")
            .responseArray { (response: DataResponse<[Book]>) in
                guard let books = response.result.value else {
                    return
                }
                self.books = books
                self.collectionView?.reloadData()
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieve()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        cell.configure(with: books[indexPath.row])
        return cell
    }

}

