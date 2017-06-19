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

    @IBOutlet weak var bookCollectionView: UICollectionView!
    
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
            
            //booksOrdered["c8fabf68-8374-48fe-a7ea-a00ccd07afff"] = BookOrder(book: books[0])
            
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! BookCollectionViewCell
        
        cell.addBookTapped.addTarget(self,action: #selector(addBookOrder(_:)),for: .touchUpInside)
        cell.removeBookTapped.addTarget(self,action: #selector(removeBookOrder(_:)),for: .touchUpInside)
        cell.configureCell(with: books[indexPath.row], indexCell: indexPath.row )

        return cell
    }
    
    func addBookOrder(_ sender: UIButton)
    {
        let tag = sender.tag
        let cell = getCurrentCell(from: tag)
        cell.numberBooksOrdered = cell.numberBooksOrdered + 1
        cell.bookNumberWanted.text = "\(cell.numberBooksOrdered)"
        
        if booksOrdered[books[tag].isbn] != nil {
            booksOrdered[books[tag].isbn]?.number += 1
        }else {
            booksOrdered[books[tag].isbn] = BookOrder(book: books[tag])
        }
        print("Add book \(books[tag].title)")
    }
    
    func removeBookOrder(_ sender: UIButton)
    {
        let tag = sender.tag
        let cell = getCurrentCell(from: tag)
        cell.numberBooksOrdered = cell.numberBooksOrdered > 0 ? cell.numberBooksOrdered - 1 : cell.numberBooksOrdered
        cell.bookNumberWanted.text = "\(cell.numberBooksOrdered)"
        
        
        if booksOrdered[books[tag].isbn] != nil {
            if (booksOrdered[books[tag].isbn]?.number)! > 0 {
                booksOrdered[books[tag].isbn]?.number -= 1
            }
        }
        print("remove book \(books[tag].title)")
    }
    
    func getCurrentCell(from index : Int) -> BookCollectionViewCell{
        let indexPath = IndexPath(item: index, section: 0)
        return self.bookCollectionView.cellForItem(at: indexPath) as! BookCollectionViewCell
    }
    
    private func getBooks() {
        let url = "http://henri-potier.xebia.fr/books/"
        Alamofire.request(url)
            .responseArray { (response: DataResponse<[Book]>) in
                print("Call URL : \(url)")
                guard let books = response.result.value else {
                    return
                }
                self.books = books
                self.bookCollectionView?.reloadData()
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

