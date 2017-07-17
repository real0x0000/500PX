//
//  Categories.swift
//  500PX
//
//  Created by Anuwat Sittichak on 7/17/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Foundation

struct Categories {

    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func list() -> [Categories] {
        var list: [Categories] = []
        list.append(Categories(id: 0, name: "Uncategorized"))
        list.append(Categories(id: 10, name: "Abstract"))
        list.append(Categories(id: 29, name: "Aerial"))
        list.append(Categories(id: 11, name: "Animal"))
        list.append(Categories(id: 5, name: "Black and White"))
        list.append(Categories(id: 1, name: "Celebrities"))
        list.append(Categories(id: 9, name: "City and Architecture"))
        list.append(Categories(id: 15, name: "Commercial"))
        list.append(Categories(id: 16, name: "Concert"))
        list.append(Categories(id: 20, name: "Family"))
        list.append(Categories(id: 14, name: "Fashion"))
        list.append(Categories(id: 2, name: "Film"))
        list.append(Categories(id: 24, name: "Fine Art"))
        list.append(Categories(id: 23, name: "Food"))
        list.append(Categories(id: 3, name: "Journalism"))
        list.append(Categories(id: 8, name: "Landscapes"))
        list.append(Categories(id: 12, name: "Macro"))
        list.append(Categories(id: 18, name: "Nature"))
        list.append(Categories(id: 30, name: "Night"))
        list.append(Categories(id: 4, name: "Nude"))
        list.append(Categories(id: 7, name: "People"))
        list.append(Categories(id: 19, name: "Performing Arts"))
        list.append(Categories(id: 17, name: "Sport"))
        list.append(Categories(id: 6, name: "Still Life"))
        list.append(Categories(id: 21, name: "Street"))
        list.append(Categories(id: 26, name: "Transportation"))
        list.append(Categories(id: 13, name: "Travel"))
        list.append(Categories(id: 22, name: "Underwater"))
        list.append(Categories(id: 27, name: "Urban Exploration"))
        list.append(Categories(id: 25, name: "Wedding"))
        return list
    }
    
}
