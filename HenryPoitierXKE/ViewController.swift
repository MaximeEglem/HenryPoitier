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

    @IBOutlet weak var BookCollectionView: UICollectionView!
    
    private var books = [Book]()
    
    private var booksOrdered = [String : BookOrder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailViewController" {
            let detailViewController = segue.destination as! DetailViewController
            
            booksOrdered["c8fabf68-8374-48fe-a7ea-a00ccd07afff"] = BookOrder(book: books[0])
            
            detailViewController.booksOrdered = self.booksOrdered
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? BookCollectionViewCell else {
            fatalError()
        }
        
        cell.configureCell(with: books[indexPath.row], indexCell: indexPath.row )

        return cell
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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

