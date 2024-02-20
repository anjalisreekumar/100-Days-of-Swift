//
//  ViewController.swift
//  project1
//
//  Created by Bridge on 15/02/24.
//

import UIKit

class ViewController: UITableViewController {

    var pics = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default //built in system type to let us work with the file system
        let path = Bundle.main.resourcePath! //set to the resource path of our app
        //Bundle contains all the resources and compiled codes needed for the app to work
        let items = try! fm.contentsOfDirectory(atPath: path) // array of all the items in the path of directory
        
        for item in items {
            if item.hasPrefix("nssl"){
                //picture to load
                
                pics.append(item)
            }
        }
        print(pics)
        pics.sort()
        title = "Storm Viewer"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pics.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pic", for: indexPath)
        cell.textLabel?.text = pics[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pics[indexPath.row]
            vc.selectedPosition = indexPath.row + 1
            vc.totalNumberOfItems = pics.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


