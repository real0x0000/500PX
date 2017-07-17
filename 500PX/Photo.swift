//
//  Photo.swift
//  500PX
//
//  Created by Anuwat Sittichak on 7/17/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

struct Photo {
    let photoId: Int
    let photoCategoryId: Int
    let imageUrl: String
    let imageName: String
    let authorName: String
    var image: UIImage?
}

extension Photo {
    
    static func parseJSON(json: JSON) -> Photo {
        let photoId = json["id"].intValue
        let photoCategoryId = json["category"].intValue
        let imageUrl = json["image_url"].stringValue
        let imageName = json["name"].stringValue
        let authorName = json["user"]["fullname"].stringValue
        return Photo(photoId: photoId, photoCategoryId: photoCategoryId, imageUrl: imageUrl, imageName: imageName, authorName: authorName, image: nil)
    }
    
}
