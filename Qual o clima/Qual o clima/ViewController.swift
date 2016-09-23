//
//  ViewController.swift
//  Qual o clima
//
//  Created by Juliana Morota on 9/22/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBAction func findWeather(sender: AnyObject) {
        
        let requestedUrl = NSURL(string:"http://www.weather-forecast.com/locations/"+cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = requestedUrl {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
                if let urlContent = data {
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let webSiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if webSiteArray!.count > 1 {
                        
                        let weatherArray = webSiteArray![1].componentsSeparatedByString("</span>")
                        
                        if weatherArray.count > 1 {
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            dispatch_async(dispatch_get_main_queue(), {
                                self.resultLabel.text = weatherSummary
                            })
                        }
                    }
                }
            }
            task.resume()
        }else{
            dispatch_async(dispatch_get_main_queue(), {
                self.resultLabel.text = "Url inválida"
            })

            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //"desfazer" o teclado
        return true
    }



}

