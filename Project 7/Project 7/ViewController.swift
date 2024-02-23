//
//  ViewController.swift
//  Project 7
//
//  Created by Bridge on 22/02/24.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetition = [Petition]()
    var filteredPetitionCopy = [Petition]()
    var isFiltered: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(rollCredits))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter Petitions", style: .plain, target: self, action: #selector(filterPetitions))
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
             urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
      
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                //ok to parse
                parseJSON(data: data)
                return
            }
        }
        showError()
        }
           
    
        
  @objc func rollCredits(){
        
      let ac = UIAlertController(title: "Credits", message: "The credit of this application is fully owned by the government of the USA", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
      
    }
  @objc  func filterPetitions(){
      let ac = UIAlertController(title: "Enter a Keyword", message: "Please enter a keyword to filter", preferredStyle: .alert)
      ac.addTextField()
      let submitAction = UIAlertAction(title: "Filter", style: .default) { [weak self,weak ac] _ in
          guard let answer = ac?.textFields?[0].text else {return}
          self?.filterBy(keyword: answer)
      }
      ac.addAction(submitAction)
      ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      present(ac, animated: true)
    }
    
    func filterBy(keyword: String) {
            if keyword.isEmpty {
                filteredPetition = petitions // Reset to show all petitions if the keyword is empty
            } else {
                filteredPetition = filteredPetitionCopy.filter { petiton in
                    petiton.body.contains(keyword) || petiton.title.contains(keyword)
                     
                }
                isFiltered = true
            }
                               
            tableView.reloadData()
        }
    
func showError(){
    let ac = UIAlertController(title: "Oops", message: "Something went wrong", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
    
    func parseJSON(data: Data) {
    let decoder = JSONDecoder()
        if let json = try? decoder.decode(Petitions.self, from: data){
            petitions = json.results
            filteredPetition = petitions
            filteredPetitionCopy = petitions
            tableView.reloadData()
        } else {
            showError()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let petition: Petition
        if isFiltered {
             petition = petitions[indexPath.row]
        } else {
             petition = filteredPetition[indexPath.row]
        }
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredPetition.count
        }
            return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
       
        if isFiltered {
            vc.detailItem = petitions[indexPath.row]
        } else {
            vc.detailItem = filteredPetition[indexPath.row]

        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

