//
//  SearchViewController.swift
//  MarvelApp
//
//  Created by Tomek Wojtyniak on 07/06/2021.
//

import UIKit


class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var results: [Result] = []
    var hideTableView = true
    var hidesearchEmptyText = false
    var hiddenbook = false
    
    @IBOutlet var ComicsTableView: UITableView!
    
    let searchBar = UISearchBar()
    
    let emptySearchText = UILabel()
    
    var book = UIImageView(image: UIImage(imageLiteralResourceName: "book-open_icon"))
    

    var message = "Start typing to find particular comics"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        emptySearchText.text = message
        view.addSubview(emptySearchText)

        
        view.addSubview(book)

        emptySearchText.isHidden =  hidesearchEmptyText
        ComicsTableView.isHidden = hideTableView
        book.isHidden = hiddenbook

        
        
        ComicsTableView.delegate = self
        ComicsTableView.dataSource = self
        
        ComicsTableView.separatorStyle = .none
        ComicsTableView.showsVerticalScrollIndicator = false
        ComicsTableView.register(ComicsTableViewCell.self, forCellReuseIdentifier: ComicsTableViewCell.imageIdentifier)
        
        
        ComicsTableView.keyboardDismissMode = .onDrag
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 20, width: view.frame.size.width-20, height: 40)
        searchBar.placeholder = "Search for a comic book"
        searchBar.tintColor = UIColor.systemBlue
        
        emptySearchText.textAlignment = .center
        emptySearchText.numberOfLines = 0
        emptySearchText.frame = CGRect(x: 0,y: 50,width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        emptySearchText.font = UIFont.systemFont(ofSize: 18)
        book.frame = CGRect(x: self.view.frame.width/2 - 50, y: self.view.frame.height/2 - 74, width: 100, height: 100)
        
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            DispatchQueue.main.async {
                self.hideTableView = false
                self.hidesearchEmptyText = true
                self.hiddenbook = true
                self.viewDidLoad()
            }
            
            
            results = []
            fetchCovers(query: text)
        } else {
//            DispatchQueue.main.async {
//                print("change view")
//                self.hideTableView = true
//                self.viewDidLoad()
//           }

            
        }
    }
    
    
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
        if imageArray!.count == 0{
            cell.configure(with: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPEAAADRCAMAAAAquaQNAAAAA1BMVEX///+nxBvIAAAAR0lEQVR4nO3BMQEAAADCoPVP7WULoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABuxZIAAeHuCGgAAAAASUVORK5CYII=")
        } else{
            let imageURLString = (imageArray?[0].path)! + "." + (imageArray?[0].extension)!
            cell.configure(with: imageURLString)
        }
        
        
        
        
        cell.comicsTitle.text = title
        cell.comicsDescription.sizeToFit()
        cell.comicsDescription.text = desc

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func fetchCovers(query: String){
        
        let urlString = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=080a502746c8a60aeab043387a56eef0&hash=6edc18ab1a954d230c1f03c590d469d2&limit=25&offset=0&orderBy=-onsaleDate&title=\(query)"
        
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
                    if JSONResult.data.count == 0{
                        DispatchQueue.main.async {
                            self?.hideTableView = true
                            self?.message = "There is no comic book \"\(query)\" in our library. Check the spelling and try again. "
                            self?.hidesearchEmptyText = false
                            self?.hiddenbook = false
                            self?.book = UIImageView(image: UIImage(imageLiteralResourceName: "book-open_icon"))
                            self?.viewDidLoad()
                        }
                    } else {
                        self?.results = JSONResult.data.results
                    }
                    self?.ComicsTableView.reloadData()
                }
            } catch {
                print(error)
            }
            
            
        }
        
        task.resume()
    }
    
}
