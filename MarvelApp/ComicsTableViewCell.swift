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
        comicsImage.clipsToBounds = true
        //comicsImage.contentMode = .scaleAspectFill
        comicsImage.layer.cornerRadius = 8.0
        
        contentView.addSubview(comicsImage)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.comicsImage.image = image
            }
            
        }
        task.resume()
    }

    
}



