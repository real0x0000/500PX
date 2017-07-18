//
//  PhotoFSViewController.swift
//  500PX
//
//  Created by Anuwat Sittichak on 7/18/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Foundation
import RxSwift
import SDWebImage
import UIKit

class PhotoFSViewController: UIViewController {
    
    let vm = PhotoFSViewModel()
    var disposeBag = DisposeBag()
    var photos: [Photo] = []
    var photoIndex: Int = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func upSwipeGesture(sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftSwipeGesture(sender: UISwipeGestureRecognizer) {
        if (photoIndex + 1) <= (photos.count) - 1 {
            photoIndex = photoIndex + 1
            displayPhoto()
        }
    }
    
    @IBAction func rightSwipeGesture(sender: UISwipeGestureRecognizer) {
        if photoIndex - 1 >= 0 {
            photoIndex = photoIndex - 1
            displayPhoto()
        }
    }
    
    @IBAction func downSwipeGesture(sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.rx_photos
            .subscribe(onNext: { [unowned self] photos in
                self.photos = photos
                self.displayPhoto()
            }).addDisposableTo(disposeBag)
    }
    
    func displayPhoto() {
        let photo = photos[photoIndex]
        titleLabel.text = photo.imageName
        authorLabel.text = photo.authorName
        print(photo.imageUrl)
        imageView.sd_setImage(with: URL(string: photo.imageUrl))
    }
    
}
