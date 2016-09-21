//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Juliana Morota on 9/21/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecording: UIButton!
    @IBOutlet weak var labelRecording: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("stop recording button pressed")
        
    }
   
    @IBAction func startRecording(sender: AnyObject) {
        
    }

}

