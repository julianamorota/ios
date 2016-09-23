//
//  ViewController.swift
//  Jogo da velha
//
//  Created by Juliana Morota on 9/23/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //1 = O, 2 = X
    var activePlayer = 1
    var gameActive = true
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    @IBAction func playAgainPressed(sender: AnyObject)
    {
        activePlayer = 1
        gameActive = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        for i in 0  ..< 9  {
            let subview = view.viewWithTag(i)
            if subview?.isKindOfClass(UIButton) == true{
                let button = subview as! UIButton
                button.setImage(nil, forState:UIControlState.Normal)
            }else{
                print("Tag \(i) is not configured right")
            }
        }
        gameOverLabel.hidden = true
        playAgain.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
    
    }
    
    @IBAction func buttonPressed(sender: AnyObject)
    {
        if gameState[sender.tag] == 0 && gameActive == true
        {
            var image = UIImage()
            
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1
            {
                image = UIImage(named: "bolinha.png")!
                activePlayer = 2
            }
            else
            {
                image = UIImage(named: "xis.png")!
                activePlayer = 1
            }
            sender.setImage(image, forState: .Normal)
            
            for combination in winningCombinations
            {
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]
                {
                    var winner = "O ganhou"
                    
                    if gameState[combination[0]] == 2
                    {
                        winner = "X ganhou"
                    }
                    gameOverLabel.text = winner
                    gameOverLabel.hidden = false
                    playAgain.hidden = false
                    
                    UIView.animateWithDuration(0.5, animations: {
                        self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
                        self.playAgain.center = CGPointMake(self.playAgain.center.x + 500, self.playAgain.center.y)
                    })
                    gameActive = false
                }
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        gameOverLabel.hidden = true
        playAgain.hidden = true
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

