//
//  ViewController.swift
//  Animacoes
//
//  Created by Juliana Morota on 9/22/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var alienImage: UIImageView!
    
    var counter = 1
    
    var timer = NSTimer()
    
    var isAnimating = true
    
    @IBAction func updateImage(sender: AnyObject) {
       
        if isAnimating == true {
            timer.invalidate()
            isAnimating = false
        }else{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.doAnimation), userInfo: nil, repeats: true)
            isAnimating = true
        }
        /*
        if counter == 5{
            counter = 1
        }
        else{
            counter += 1
        }
        
        
        alienImage.image = UIImage(named: "alien\(counter).jpg")
 
         */
    }
    
    func doAnimation() {
        if counter == 5{
            counter = 1
        }
        else{
            counter += 1
        }
        
        alienImage.image = UIImage(named: "alien\(counter).jpg")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.doAnimation), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    override func viewDidLayoutSubviews() {
        //alienImage.center = CGPointMake(alienImage.center.x - 400, alienImage.center.y)
        //alienImage.alpha = 0
        alienImage.frame = CGRectMake(100, 20, 0, 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1) { 
            //self.alienImage.center = CGPointMake(self.alienImage.center.x + 400, self.alienImage.center.y)
            //self.alienImage.alpha = 1
            self.alienImage.frame = CGRectMake(100, 20, 100, 200)
        }
    }
 */


}

