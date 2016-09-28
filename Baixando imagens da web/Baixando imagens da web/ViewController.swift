//
//  ViewController.swift
//  Baixando imagens da web
//
//  Created by Juliana Morota on 9/27/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageContainer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
         *PEGAR IMAGEM DA INTERNET SIMULTÂNEAMENTE
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/7/7b/Beethoven_3.jpg")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            if error != nil {
                
                print(error)
            } else {
                if let imagem = UIImage(data: data!){
                    self.imageContainer.image = imagem
                }
            }
        }
         */
        
        
        
        
        //SALVANDO A IMAGEM DA INTERNET LOCAL
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/7/7b/Beethoven_3.jpg")
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            if error != nil {
                print(error)
            } else {
                if let imagem = UIImage(data: data!){
                    self.imageContainer.image = imagem
                    
                    var documentsDirectory:String?
                    var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    if paths.count > 0 {
                        documentsDirectory = paths[0] as? String
                        let savePath = documentsDirectory! + "/beethoven.jpg"
                        NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                        self.imageContainer.image = UIImage(named: savePath)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

