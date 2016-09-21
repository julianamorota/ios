//
//  ViewController.swift
//  Hello World
//
//  Created by Juliana Morota on 9/20/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func submit(sender: AnyObject) {
        print("Button tapped")
        label.text = ageField.text;
    }
       override func viewDidLoad() {
        super.viewDidLoad()
        print("Ola pessoal")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

