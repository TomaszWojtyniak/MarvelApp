//
//  MainPageViewModel.swift
//  MarvelApp
//
//  Created by Tomasz Wojtyniak on 13/07/2021.
//

import Foundation
import UIKit
import Kingfisher

public class MainPageViewModel {
    
    
    init() {
        fetchData()
    }
    
    private let urlString = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=080a502746c8a60aeab043387a56eef0&hash=6edc18ab1a954d230c1f03c590d469d2&limit=25&offset=0&orderBy=-onsaleDate"
    
    
    var results: [Result] = []
    
    var isLoaded = false
    

        
    public func title(indexPathRow: Int) -> String {
        
        return results[indexPathRow].title
    }
    
    public func writters(indexPathRow: Int) -> String {
        let availableCreators = results[indexPathRow].creators.available //check API available value to see if creators are named

        let countCreators = results[indexPathRow].creators.items?.count

        var creators =  " "
        
        if availableCreators != 0{

            var allCreators = ""
            for i in 0..<countCreators!{
                let creators = results[indexPathRow].creators.items?[i]
                if creators?.role == "writer"{
                    let temp = creators!.name + ", "
                    allCreators = allCreators + temp
                }
            }
            if allCreators == ""{
                creators =  " "
            } else {
                creators =  allCreators
            }
        }


        return creators
    }

//    public func cover(indexPathRow: Int) -> UIImage {
//
//        let imageArray = results[indexPathRow].images
//        if imageArray!.count == 0{  //if comic dont have a cover display white background image
//            return image
//        } else{
//            let imageURLString = (imageArray?[0].path)! + "." + (imageArray?[0].extension)!
//            configure(urlString: imageURLString)//Get image from url
//            return image
//        }
//
//    }
    
    public func description(indexPathRow: Int) -> String {

        return results[indexPathRow].description ?? " "
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
                    self?.isLoaded = true
                    print("data loaded")
                    
                    
                    
                }
            } catch {
                print(error)
            }
            
            
        }
        
        task.resume()
    }
    
    func configure(urlString: String){
        
        //KF.url(urlString).set(to: image)
        
        
        
    }
    
    
}

