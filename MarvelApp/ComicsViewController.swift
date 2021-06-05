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
        cell.comicsTitle.text = "title"
        cell.comicsWriter.text = "writer"
        cell.comicsDescription.sizeToFit()
        cell.comicsDescription.text = "Jen Walters used to fight for justice in the courtroom as a lawyer and outside of it as the super hero known as She-Hulk. But after the events of Civil War, Jen's Hulk persona has changed."
        
        
        
        return cell
    }
    
    
    @IBOutlet var ComicsTableView: UITableView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ComicsTableView.register(ComicsTableViewCell.self, forCellReuseIdentifier: "ComicsCell")
        ComicsTableView.delegate = self
        ComicsTableView.dataSource = self
        ComicsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
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
