//
//  PhotoListViewModel.swift
//  500PX
//
//  Created by Anuwat Sittichak on 7/17/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift
import SwiftyJSON

class PhotoListViewModel {
    
    private let consumerKey = "sbCmiiVEJKq9tpZNqSJug4BB7WWQCbL4QAVwBdDI"
    let rx_categoryId: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    let rx_categoryName: BehaviorSubject<String> = BehaviorSubject(value: "")
    let rx_photos: BehaviorSubject<[Photo]> = BehaviorSubject(value: [])
    let rx_page: BehaviorSubject<Int> = BehaviorSubject(value: 1)
    
    func loadPhotos() {
        let headers = [
            "Content-Type": "application/json"
        ]
        var parameters: [String: Any] = [:]
        parameters["only"] = categoryName
        parameters["page"] =

//        print(parameters)
        Alamofire.request("https://api.500px.com/v1/photos?feature=fresh_today&consumer_key=\(consumerKey)", parameters: parameters, headers: headers)
            .responseData { resp in
            let json = JSON(resp.result.value!)
            let photos = json["photos"].map { (_, js) in Photo.parseJSON(json: js) }
            self.rx_photos.onNext(photos)
        }
    }
    
}

extension PhotoListViewModel {
    
    var categoryId: Int {
        get { return try! rx_categoryId.value() }
        set(id) { rx_categoryId.onNext(id) }
    }
    
    var categoryName: String {
        get { return try! rx_categoryName.value() }
        set(name) { rx_categoryName.onNext(name) }
    }
    
    var page: Int {
        get { return try! rx_page.value() }
        set(page) { rx_page.onNext(page) }
    }
    
}
