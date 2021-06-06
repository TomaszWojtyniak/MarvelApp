//
//  ComicsTableViewCell.swift
//  MarvelApp
//
//  Created by Tomek Wojtyniak on 05/06/2021.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {

    @IBOutlet var comicsTitle: UILabel!

    @IBOutlet var comicsImage: UIImageView!

    @IBOutlet var comicsWriter: UILabel!

    @IBOutlet var comicsDescription: UILabel!
    

    @IBOutlet var ComicsView: UIView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    

    
}



