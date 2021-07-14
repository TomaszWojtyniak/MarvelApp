//
//  ComicsViewController.swift
//  MarvelApp
//
//  Created by Tomek Wojtyniak on 05/06/2021.
//

import UIKit


class ComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var ComicsTableView: UITableView!
    
    var comicsViewModel = MainPageViewModel()
    
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
        cell.ComicsView.layer.masksToBounds = false
        cell.ComicsView.clipsToBounds = false
        cell.comicsDescription.sizeToFit()
        
        cell.comicsImage.layer.cornerRadius = 8.0
        
        if comicsViewModel.isLoaded == true{
            cell.comicsTitle.text = comicsViewModel.title(indexPathRow: indexPath.row)
            cell.comicsDescription.text = comicsViewModel.description(indexPathRow: indexPath.row)
            cell.comicsWriter.text = comicsViewModel.writters(indexPathRow: indexPath.row)
            //cell.comicsImage.image = comicsViewModel.cover(indexPathRow: indexPath.row)
            
        } else {
            reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print(comicsViewModel.results.count)
        return 24 //count numbers of comics from API request
    }
    
    func reloadData(){
        
            ComicsTableView.reloadData() //reload to display
        
    
    }
}






