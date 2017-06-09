//
//  CollectionViewCell.swift
//  HenryPoitierXKE
//
//  Created by Simone Civetta on 09/06/2017.
//  Copyright © 2017 Xebia IT Architects. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func configure(with book: Book) {
        let url = URL(string: book.cover)
        image.kf.setImage(with: url)
        title.text = book.title
        price.text = "\(book.price) €"
    }
}
