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
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    func setupView() {
        addSubview(cellView)


        //self.selectionStyle = .none
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }
    
    

}
