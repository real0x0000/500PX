//
//  CategoriesViewController.swift
//  500PX
//
//  Created by Anuwat Sittichak on 7/13/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var categories = Categories.list()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        tableView.reloadData()
    }

}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 30
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.nameLabel.text = categories[indexPath.row].name
        return cell
    }
    
}

extension CategoriesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "displayPhotos") {
            let indexPath = tableView.indexPathForSelectedRow!
            let category = categories[indexPath.row]
            let view = segue.destination as! PhotoListViewController
            view.vm.categoryId = category.id
            view.vm.categoryName = category.name
        }
    }
    
}

class CategoriesCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

