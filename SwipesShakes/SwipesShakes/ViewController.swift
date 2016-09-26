//
//  ViewController.swift
//  SwipesShakes
//
//  Created by Juliana Morota on 9/26/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    
    var sounds = ["radiostatic", "blast", "nails", "clock", "match"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        
    }
    
    func swiped(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("swiped right")
            case UISwipeGestureRecognizerDirection.Up:
                print("swiped up")
            default:
                break
            }
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        //se o dispositivo for shaked
        if event?.subtype == UIEventSubtype.MotionShake {
            let randomNumber = Int(arc4random_uniform(UInt32(sounds.count)))
        
        let fileLocation = NSBundle.mainBundle().pathForResource(sounds[randomNumber], ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: fileLocation!))
            player.play()
        }catch{
            //process errors
        }
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

