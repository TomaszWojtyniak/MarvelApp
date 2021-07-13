//
//  MainPageViewModel.swift
//  MarvelApp
//
//  Created by Tomasz Wojtyniak on 13/07/2021.
//

import Foundation
import UIKit

public class MainPageViewModel {
    private let comicBook: ComicBook
    
    
    init(comicBook: ComicBook? = nil) {
        self.comicBook = comicBook!
    }
    
    private let urlString = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=080a502746c8a60aeab043387a56eef0&hash=6edc18ab1a954d230c1f03c590d469d2&limit=25&offset=0&orderBy=-onsaleDate"
    
    
    var results: [Result] = []
        
    public func title(indexPathRow: Int) -> String {
        comicBook.title = results[indexPathRow].title
        return comicBook.title
    }
    
    public func writters(indexPathRow: Int) -> String {
        let availableCreators = results[indexPathRow].creators.available //check API available value to see if creators are named
        
        let countCreators = results[indexPathRow].creators.items?.count

        if availableCreators == 0{
            comicBook.creators =  " "
        } else {
            var allCreators = ""
            for i in 0..<countCreators!{
                let creators = results[indexPathRow].creators.items?[i]
                if creators?.role == "writer"{
                    let temp = creators!.name + ", "
                    allCreators = allCreators + temp
                }
            }
            if allCreators == ""{
                comicBook.creators =  " "
            } else {
                comicBook.creators =  allCreators
            }
        }

        
        return comicBook.creators
    }
    
    public func cover(indexPathRow: Int) -> UIImage {
        
        let imageArray = results[indexPathRow].images
        if imageArray!.count == 0{  //if comic dont have a cover display white background image
            configure(with: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPEAAADRCAMAAAAquaQNAAAAA1BMVEX///+nxBvIAAAAR0lEQVR4nO3BMQEAAADCoPVP7WULoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABuxZIAAeHuCGgAAAAASUVORK5CYII=")
        } else{
            let imageURLString = (imageArray?[0].path)! + "." + (imageArray?[0].extension)!
            configure(with: imageURLString) //Get image from url
        }
    
        return comicBook.image
    }
    
    public func description(indexPathRow: Int) -> String {
        
        comicBook.description = results[indexPathRow].description ?? " "
        return comicBook.description
    }
    
    func fetchData(){
        
        //API authorization values to get API values
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Authorization": "914341525b1b3e445c89b40c38442a2b8d0680f7"
        ]
        
        //get data
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
                    self?.results = JSONResult.data.results //get data from API and store them into the results array
                    //self?.ComicsTableView.reloadData() //reload to display
                    
                }
            } catch {
                print(error)
            }
            
            
        }
        
        task.resume()
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
                //comicsImage.image = image
                self.comicBook.image = image!
            }
            
        }
        task.resume()
    }
    
    
}
