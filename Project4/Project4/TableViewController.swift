//
//  TableViewController.swift
//  Project4
//
//  Created by Bridge on 20/02/24.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com","hackingwithswift.com","indiangov.com","samsung.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Webkit") as? ViewController {
            vc.website = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    
}
