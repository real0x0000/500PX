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
    var refreshControl: UIRefreshControl!
    
    let vm = PhotoListViewModel()
    let itemPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsetsMake(-10.0, 10.0, 10.0, 10.0)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        vm.currentPage = 1
        vm.loadPhotos()
        
        self.title = vm.categoryName
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadPhotos), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        vm.rx_photos
            .subscribe(onNext: { [unowned self] in
                self.photos.append(contentsOf: $0)
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }).addDisposableTo(disposeBag)

    }
    
    func reloadPhotos() {
        photos = []
        vm.currentPage = 1
        vm.totalPage = 0
        vm.loadPhotos()
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
        cell.imageView.sd_setImage(with: URL(string: photo.imageUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 {
            if (vm.currentPage + 1) <= vm.totalPage {
                vm.currentPage += 1
                print(vm.currentPage)
                print(vm.totalPage)
                vm.loadPhotos()
            }
        }
    }

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

extension PhotoListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "displayFullPhoto") {
            let indexPath = collectionView.indexPathsForSelectedItems!
            let view = segue.destination as! PhotoFSViewController
            view.vm.photos = photos
            view.photoIndex = indexPath.last!.row
        }
    }
    
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}
