//
//  ViewController.swift
//  Project5
//
//  Created by Bridge on 20/02/24.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openPromptAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
            if allWords.isEmpty {
                allWords = ["earthworm"]
            }
        
        startGame()
    }

    
   @objc func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    
    @objc func openPromptAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
            
        }
        
        ac.addAction(submitAction)
        present(ac,animated: true)
    }

    
    func submit(_ answer: String){
        
        let lowerAns = answer.lowercased()
        let errTitle: String
        let errMsg: String
        
            if hasMoreThanThreeLetters(word: lowerAns){
                if isPossible(word: lowerAns){
                    if isOriginal(word: lowerAns){
                        if isReal(word: lowerAns){
                            usedWords.insert(lowerAns, at: 0)
                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                            return
                        }
                        else {
                            
                            showErrorMsg(errTitle: "Word Not Recognized", errMsg: "Please enter a real word")
                        }
                    } else {
                        
                        showErrorMsg(errTitle: "Not original", errMsg: "Be more original")
                    }
                } else {
                    
                    showErrorMsg(errTitle: "Not Possible", errMsg: "The word is not possible")
                }
            } else {
              
                showErrorMsg(errTitle: "Too Short", errMsg: "Please enter more than three letters")
            }
            
        
    
        
    }
    
    func showErrorMsg(errTitle: String , errMsg: String){
        
       let ac = UIAlertController(title: errTitle, message: errMsg, preferredStyle: .alert)
       ac.addAction(UIAlertAction(title: "OK", style: .default))
       present(ac,animated: true)
        
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {return false}
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if word == title {
            return false
        } else {
            return  misspelledRange.location == NSNotFound
        }
//
//        if misspelledRange.location == NSNotFound {
//            return true
//        }
//        else {
//            return false
//        }
        
    }
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    
    func  hasMoreThanThreeLetters(word: String) -> Bool {
        if word.utf16.count < 3 {
            return false
        } else {
            return true
        }
    }
    
}

