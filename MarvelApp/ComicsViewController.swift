//
//  ComicsViewController.swift
//  MarvelApp
//
//  Created by Tomek Wojtyniak on 05/06/2021.
//

import UIKit

struct APIResponse: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML:String
    let etag: String
    let data: Data
}

struct Data: Codable {
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let title: String
    let description: String?
    let images: [Image]?
    let creators: Creator
}

struct Creator: Codable {
    let items: [Item]?
    let available: Int
}

struct Item: Codable{
    let name: String
    let role: String
}

struct Image: Codable {
    let path: String
    let `extension`: String
}

class ComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsCell") as! ComicsTableViewCell

        cell.ComicsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.ComicsView.layer.shadowColor = UIColor.black.cgColor
        cell.ComicsView.layer.shadowRadius = 10

        cell.ComicsView.layer.shadowOpacity = 0.1
        cell.ComicsView.layer.masksToBounds = false;
        cell.ComicsView.clipsToBounds = false;
        
        cell.comicsImage.layer.cornerRadius = 8.0
        
        let title = results[indexPath.row].title
        let desc = results[indexPath.row].description ?? " "
        let availableCreators = results[indexPath.row].creators.available
        
        let countCreators = results[indexPath.row].creators.items?.count

        if availableCreators == 0{
            cell.comicsWriter.text = " "
        } else {
            var allCreators = ""
            for i in 0..<countCreators!{
                let creators = results[indexPath.row].creators.items?[i]
                if creators?.role == "writer"{
                    let temp = creators!.name + ", "
                    allCreators = allCreators + temp
                }

            }
            if allCreators == ""{
                cell.comicsWriter.text = " "
            } else {
                cell.comicsWriter.text = allCreators
            }
            
        }
        

        
        let imageArray = results[indexPath.row].images
        print(title)
        if imageArray!.count == 0{
            print("no image")
        } else{
            let imageURLString = (imageArray?[0].path)! + "." + (imageArray?[0].extension)!
            cell.configure(with: imageURLString)
        }
        
        
        
        
        cell.comicsTitle.text = title
        cell.comicsDescription.sizeToFit()
        cell.comicsDescription.text = desc

        return cell
    }
    
    
    @IBOutlet var ComicsTableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ComicsTableView.delegate = self
        ComicsTableView.dataSource = self
        
        ComicsTableView.separatorStyle = .none
        ComicsTableView.showsVerticalScrollIndicator = false
        fetchCovers()
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    var results: [Result] = []
    
    
    
    let urlString = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=080a502746c8a60aeab043387a56eef0&hash=6edc18ab1a954d230c1f03c590d469d2&limit=25&offset=0&orderBy=-onsaleDate"
    
    func fetchCovers(){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Authorization": "914341525b1b3e445c89b40c38442a2b8d0680f7"
        ]
        guard let url = URL(string: urlString) else {
            return
        }
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let JSONResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = JSONResult.data.results
                    self?.ComicsTableView.reloadData()
                }
            } catch {
                print(error)
            }
            
            
        }
        
        task.resume()
    }

}
