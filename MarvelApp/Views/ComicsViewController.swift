//
//  ComicsViewController.swift
//  MarvelApp
//
//  Created by Tomek Wojtyniak on 05/06/2021.
//

import UIKit


class ComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - variables and IBOutlets
    
    @IBOutlet var ComicsTableView: UITableView!
    
    var comicsViewModel = MainPageViewModel()
    
    var results: [Result] = []
    
    
    // MARK: - TableView functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ComicsTableView.delegate = self
        ComicsTableView.dataSource = self
        ComicsTableView.register(ComicsTableViewCell.self, forCellReuseIdentifier: ComicsTableViewCell.imageIdentifier)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsCell") as! ComicsTableViewCell

        
        //Comics table design
        ComicsTableView.separatorStyle = .none
        ComicsTableView.showsVerticalScrollIndicator = false
        
        //Comics cell design
        cell.ComicsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.ComicsView.layer.shadowColor = UIColor.black.cgColor
        cell.ComicsView.layer.shadowRadius = 10
        cell.ComicsView.layer.shadowOpacity = 0.1
        cell.ComicsView.layer.masksToBounds = false;
        cell.ComicsView.clipsToBounds = false;
        
        cell.comicsDescription.sizeToFit()
        
        cell.comicsImage.layer.cornerRadius = 8.0
        
        cell.comicsTitle.text = comicsViewModel.title(indexPathRow: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count //count numbers of comics from API request
    }
    


}






