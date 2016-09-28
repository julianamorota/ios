//
//  ViewController.swift
//  Web View Exemplo
//
//  Created by Juliana Morota on 9/27/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        *EXIBIR A PÁGINA
        let url = NSURL(string: "https://www.mirago.com.br/")!
        let request = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
        
        */
        
        let html = "<html><body><h1>Meu site<p>um parágrafo</p></h1></body></html>"
        webView.loadHTMLString(html, baseURL: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

