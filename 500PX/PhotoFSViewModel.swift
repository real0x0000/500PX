//
//  PhotoFSViewModel.swift
//  500PX
//
//  Created by Anuwat Sittichak on 7/18/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Foundation
import RxSwift

class PhotoFSViewModel {
    
    let rx_photos: BehaviorSubject<[Photo]> = BehaviorSubject(value: [])
    
}

extension PhotoFSViewModel {
    
    var photos: [Photo] {
        get { return try! rx_photos.value() }
        set(photos) { rx_photos.onNext(photos) }
    }
    
}
