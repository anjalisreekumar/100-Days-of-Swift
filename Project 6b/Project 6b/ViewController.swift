//
//  ViewController.swift
//  Project 6b
//
//  Created by Bridge on 21/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "That"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .green
        label2.text = "Those"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .gray
        label3.text = "This"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .blue
        label4.text = "When"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .cyan
        label5.text = "Who"
        label5.sizeToFit()
        
        let label6 = UILabel()
        label6.translatesAutoresizingMaskIntoConstraints = false
        label6.backgroundColor = .red
        label6.text = "That"
        label6.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        view.addSubview(label6)
        
        //        let viewsDictionary = ["label1": label1, "label2" : label2 , "label3":label3 , "label4" : label4 , "label5" : label5 , "label6" : label6]
        //
        //
        //        for label in viewsDictionary.keys {
        //            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
        //
        //
        //
        //        }
        //
        //        let metrics = ["labelHeight" : 88]
        //        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-[label6(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        //
        //    }
        
        var previous: UILabel?
        
        
        for label in [label1,label2,label3,label4,label5,label6] {
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
//            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0).isActive = true
//            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: 0).isActive = true
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0/5.0, constant: -10).isActive = true
            
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            previous = label
        }
        
        
        
    }
    
}
