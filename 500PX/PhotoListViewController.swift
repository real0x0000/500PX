//
//  PhotoListViewController.swift
//  500PX
//
//  Created by Anuwat Sittichak on 7/17/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Foundation
import SDWebImage
import RxSwift
import UIKit

class PhotoListViewController: UIViewController {
    
    var photos: [Photo] = []
    var disposeBag = DisposeBag()
    
    let vm = PhotoListViewModel()
    let itemPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsetsMake(-10.0, 10.0, 10.0, 10.0)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        vm.loadPhotos()
        
        vm.rx_photos
            .subscribe(onNext: { [unowned self] in
                self.photos = $0
                self.collectionView.reloadData()
            }).addDisposableTo(disposeBag)

    }
    
}

extension PhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func initCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        cell.titleLabel.text = photo.imageName
        cell.authorLabel.text = photo.authorName
        cell.imageView.sd_setImage(with: URL(string: "\(photo.imageUrl)"))
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == productsData.count - 1 {
//            if let next = nextUrl {
//                vm.fetchNextProducts(nextUrl: next)
//                loadingView.isHidden = false
//                indicatorView.startAnimating()
//            }
//        }
//    }
    
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}
