//
//  ViewController.swift
//  rock-paper-scissors
//
//  Created by Mert Başkaya on 13.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let choises = [
        1: "Rock",
        2: "Paper",
        3: "Scissors"
    ]

    var p1Score: Int = 0
    var p2Score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        gameRestartHandler()
    }
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var player1ImageView: UIImageView!
    @IBOutlet weak var player2ImageView: UIImageView!
    
    // Randomizes 2 choises and calls the gameLogicHandler
    @IBAction func playButtonPressed(_ sender: UIButton) {
        let choise1 = Int.random(in: 1...3)
        let choise2 = Int.random(in: 1...3)
        gameLogicHandler(choise1: choise1, choise2: choise2)
        player1ImageView.image = gameImageHandler(imageIndex: choise1)
        player2ImageView.image = gameImageHandler(imageIndex: choise2)
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        gameRestartHandler()
    }
    
    // Rock-Paper-Scissors Game logic
    func gameLogicHandler(choise1:Int, choise2:Int) -> Void {
        if(choise1 == choise2) { roundWinHandler(player: 0) }
        else if (choise1 == 1) {
            if (choise2 == 2) { roundWinHandler(player: 2) }
            else { roundWinHandler(player: 1) }
        }
        else if (choise1 == 2) {
            if (choise2 == 3) { roundWinHandler(player: 2) }
            else { roundWinHandler(player: 1) }
        }
        else if (choise1 == 3) {
            if (choise1 == 3) { roundWinHandler(player: 2) }
            else { roundWinHandler(player: 1) }
        }
        showScore()
        gameWinHandler()
    }
    
    // Returns asset from directory
    func gameImageHandler(imageIndex:Int) -> UIImage {
        return UIImage(named: choises[imageIndex]!)!
    }
    
    // Adds +1 score to the given player
    func roundWinHandler(player:Int) -> Void {
        switch player {
        case 1:
            scoreHandler(player: player)
            break
        case 2:
            scoreHandler(player: player)
            break
        default:
            break
        }
    }
    
    // Checks if any of the two players has reached 3 round wins
    // If so, disables the play button and enables the restart button
    // And displays winner information
    func gameWinHandler() -> Void {
        if p1Score == 3 || p2Score == 3 {
            playButton.isUserInteractionEnabled = false
            playButton.alpha = 0.5
            restartButton.isHidden = false
            if p1Score > p2Score {
                player1Label.text = "Winner"
                player2Label.text = "Loser"
            } else {
                player2Label.text = "Winner"
                player1Label.text = "Loser"
            }
        }
    }
    
    // Handles both restart and initialization of the game
    func gameRestartHandler() -> Void {
        // Below two lines are useless on initialization phase
        playButton.isUserInteractionEnabled = true
        playButton.alpha = 1.0
        scoreLabel.text = "0 - 0"
        restartButton.isHidden = true
        p1Score = 0
        p2Score = 0
        player1Label.text = "PLAYER 1"
        player2Label.text = "PLAYER 2"
        player1ImageView.image = nil
        player2ImageView.image = nil
    }
    
    // Adds 1 to a given players score
    func scoreHandler(player:Int) -> Void {
        if player == 1 { p1Score += 1 }
        else { p2Score += 1 }
    }
    
    // Shows score
    func showScore() -> Void {
        scoreLabel.text = "\(p1Score) - \(p2Score)"
    }

}

