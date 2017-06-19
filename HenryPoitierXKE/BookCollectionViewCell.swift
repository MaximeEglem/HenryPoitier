//
//  BookCollectionViewCell.swift
//  HenryPoitierXKE
//
//  Created by Maxime Eglem on 15/06/2017.
//  Copyright © 2017 Xebia IT Architects. All rights reserved.
//

import UIKit
import Kingfisher


class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addBookTapped: UIButton!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var removeBookTapped: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bookNumberWanted: UITextField!
    
    var numberBooksOrdered : Int = 0
    
    func configureCell(with book: Book, indexCell: Int) {
        
        addBookTapped.tag = indexCell
        
        bookNumberWanted.tag = indexCell
        titleLabel.text = book.title
        priceLabel.text = "\(book.price) €"
        
        let url = URL(string: book.cover)
        let resource = ImageResource(downloadURL: url!, cacheKey: book.cover)
        self.bookImageView.kf.setImage(with: resource)
        
    }

}
