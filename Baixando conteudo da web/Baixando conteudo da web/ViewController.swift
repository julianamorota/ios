//
//  ViewController.swift
//  Baixando conteudo da web
//
//  Created by Juliana Morota on 9/22/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.stackoverflow.com")!
        
        webView.loadRequest(NSURLRequest(URL: url))
        
        /*
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                dispatch_async(dispatch_get_main_queue(), {
                    self.webView.loadHTMLString(String(webContent), baseURL: nil)
                })
                
            }else{
                
            }
        }
        
        task.resume()
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

