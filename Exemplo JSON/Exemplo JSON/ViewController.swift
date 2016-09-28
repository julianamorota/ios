//
//  ViewController.swift
//  Exemplo JSON
//
//  Created by Juliana Morota on 9/27/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //url do json
        let url = NSURL(string: "https://api.myjson.com/bins/2ngac")
        
        //criando uma tarefa, compartilhada
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if let urlContent = data {
                do{
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    print(jsonResult)
                    //printar um tipo
                    print(jsonResult["menu"]!)
                }catch {
                    print("JSON Serialization failed")
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

