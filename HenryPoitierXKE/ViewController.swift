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
import Kingfisher

class ViewController: UICollectionViewController {

    @IBOutlet weak var BookCollectionView: UICollectionView!
    private var books = [Book]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
//        self.BookCollectionView.delegate = self
//        self.BookCollectionView.dataSource = self
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
                self.BookCollectionView?.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? BookCollectionViewCell else {
            fatalError()
        }
        
        //configure cell
        let book = books[indexPath.row]
        cell.titleLabel.text = book.title

        let url = URL(string: book.cover)
        let resource = ImageResource(downloadURL: url!, cacheKey: book.cover)
        cell.bookImageView.kf.setImage(with: resource)

        return cell
    }
}

