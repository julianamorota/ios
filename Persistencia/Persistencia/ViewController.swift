//
//  ViewController.swift
//  Persistencia
//
//  Created by Juliana Morota on 9/22/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSUserDefaults.standardUserDefaults().setObject("Teste", forKey: "name")
        let name = NSUserDefaults.standardUserDefaults().objectForKey("name")
        print(name)
        
        let arr = [1, 2, 3, 4]
        NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
        let userArray = NSUserDefaults.standardUserDefaults().objectForKey("array")! as! NSArray
        for x in userArray {
            print(x)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

