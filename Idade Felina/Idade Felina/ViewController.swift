//
//  ViewController.swift
//  Idade Felina
//
//  Created by Juliana Morota on 9/20/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catAgeTextField: UITextField!
    
    @IBOutlet weak var resultAge: UILabel!
    
    @IBAction func findCatAge(sender: AnyObject) {
        var catAge = Int(catAgeTextField.text!)!
        catAge = catAge * 7
        resultAge.text = "A idade do seu gato é \(catAge)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

