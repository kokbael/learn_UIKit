//
//  FormTableViewController.swift
//  UIViewDemo
//
//  Created by 김동영 on 3/13/25.
//

import UIKit

class FormTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.separatorColor = .black
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 3:
            return 3
        default:
            return 2
        }    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        // Configure the cell...
        var config = UIListContentConfiguration.subtitleCell()
        config.text = "Section: \(indexPath.section), Row: \(indexPath.row)"
        cell.contentConfiguration = config

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 200
        default:
            return 50
        }
    }
    
}

#Preview {
    FormTableViewController(style: .insetGrouped)
 }
