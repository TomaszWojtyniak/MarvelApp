//
//  ComicsViewController.swift
//  MarvelApp
//
//  Created by Tomek Wojtyniak on 05/06/2021.
//

import UIKit

class ComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsCell") as! ComicsTableViewCell

        cell.ComicsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.ComicsView.layer.shadowColor = UIColor.black.cgColor
        cell.ComicsView.layer.shadowRadius = 10

        cell.ComicsView.layer.shadowOpacity = 0.05
        cell.ComicsView.layer.masksToBounds = false;
        cell.ComicsView.clipsToBounds = false;
        
        
        
        cell.comicsTitle.text = "Star wars clone wars"
        cell.comicsWriter.text = "written by tomasz"
        cell.comicsDescription.sizeToFit()
        cell.comicsDescription.text = "Jen Walters used to fight for justice in the courtroom as a lawyer and outside of it as the super hero known as She-Hulk. But after the events of Civil War, Jen's Hulk persona has changed."

        return cell
    }
    
    
    @IBOutlet var ComicsTableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ComicsTableView.delegate = self
        ComicsTableView.dataSource = self
        
        ComicsTableView.separatorStyle = .none
        ComicsTableView.showsVerticalScrollIndicator = false
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
