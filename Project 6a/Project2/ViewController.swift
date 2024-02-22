//
//  ViewController.swift
//  Project2
//
//  Created by Bridge on 15/02/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var buttonOne: UIButton!
    
    @IBOutlet var buttonTwo: UIButton!
    
    @IBOutlet var buttonThree: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numOfQns = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(systemName: "info.circle") , style: .plain, target: self, action: #selector(currentScore))
        
        buttonOne.layer.borderWidth = 1
        buttonTwo.layer.borderWidth = 1
        buttonThree.layer.borderWidth = 1
                
        buttonOne.clipsToBounds = true
        buttonTwo.clipsToBounds = true
        buttonThree.clipsToBounds = true

        buttonOne.layer.borderColor = UIColor.lightGray.cgColor
        buttonTwo.layer.borderColor = UIColor.lightGray.cgColor
        buttonThree.layer.borderColor = UIColor.lightGray.cgColor

        countries +=
        ["estonia","france","italy","nigeria","monaco","germany","ireland","poland","russia","spain","us","uk"]
      askQns(with: nil)
        
    }
    
    func askQns(with action: UIAlertAction!){
        numOfQns += 1
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) Current Score = \(score)"
        
    }


    @IBAction func didTapFlag(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct"
        } else {
            title = "Wrong!That's the flag of \(countries[sender.tag])"
            score -= 1
        }
        let ac =  UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)

        if numOfQns == 10 {
            ac.addAction(UIAlertAction(title: "Finish", style: .destructive , handler: { _ in
                self.finishGame()
            }))

        }
        else {
            ac.addAction(UIAlertAction(title: "Continue", style: .default , handler: askQns))
        }
        present(ac,animated: true)

    }
    
    func finishGame(){
        self.score = 0
        self.numOfQns = 0
        askQns(with: nil)
    }
    
    @objc func currentScore() {
        let text = "Your current score is \(self.score)"
        
        let ac = UIAlertController(title: "Current Score", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .destructive)
        ac.addAction(action)
        present(ac, animated: true)
    }
    
}

