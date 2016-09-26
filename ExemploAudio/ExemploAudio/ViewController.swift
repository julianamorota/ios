//
//  ViewController.swift
//  ExemploAudio
//
//  Created by Juliana Morota on 9/26/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func player(sender: AnyObject) {
        player.play()
    }
    
    @IBAction func pause(sender: AnyObject) {
        player.pause()
    }
    
    @IBAction func adjustVolume(sender: AnyObject) {
        player.volume = slider.value
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioPath = NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!
        
        
        //tipo try catch
        do{
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
        }catch{
            // process the error
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

