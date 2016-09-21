//
//  ViewController.swift
//  NumeroPrimo
//
//  Created by Juliana Morota on 9/21/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func isPrime(sender: AnyObject) {
        
        if let number = Int(numberTextField.text!) {
            var isPrime = true
            
            if number == 1{
                isPrime = false
            }
                
            else if number != 2 && number != 1 {
                for i in 2 ..< number {
                    if number % i == 0 {
                        isPrime = false
                        break
                    }
                }
            }
            
            if isPrime {
                resultLabel.text = "O número \(number) é primo"
            } else {
                resultLabel.text = "O número \(number) não é primo"
            }
            
        } else {
            resultLabel.text = "Por favor, insira um número inteiro"
        }
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

