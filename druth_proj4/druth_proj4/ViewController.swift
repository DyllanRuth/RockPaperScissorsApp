//
//  ViewController.swift
//  druth_proj4
//
//  Created by STUDENT-SP22 on 2/24/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    enum GameState {
        case start
        case win
        case lose
        case draw
    }
    enum Sign {
        case rock
        case paper
        case scissors
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.\
        updateUI(forState: .start)
    }
    
    func updateUI(forState state: GameState){
        switch state {
        case .start:
            statusLabel.text = "🤖"
            view.backgroundColor = .gray
            playAgainButton.isHidden = true
            
            rockButton.isHidden = false
            paperButton.isHidden = false
            scissorsButton.isHidden = false
            
            statusLabel.text = "Rock, Paper, Scissors!"
            
        case .win:
            statusLabel.text = "you won!"
            view.backgroundColor = .green
            AudioServicesPlaySystemSound(1016)
        case .lose:
            statusLabel.text = "you lose!"
            view.backgroundColor = .red
            AudioServicesPlaySystemSound(1006)
        case .draw:
            statusLabel.text = "It's a draw!"
            view.backgroundColor = .yellow
            AudioServicesPlaySystemSound(1116)
        }
    }
    @IBAction func rockAction(_ sender: Any) {
        checkResult(userChoice: .rock)
    }
    @IBAction func paperAction(_ sender: Any) {
        checkResult(userChoice: .paper) // CALL BACK FUNCTION
    }
    @IBAction func scissorsAction(_ sender: Any) {
        checkResult(userChoice: .scissors)
    }
    @IBAction func playAgainButton(_ sender: Any) {
        updateUI(forState: .start)
    }
    func checkResult(userChoice: Sign){ // input parameter
        let i = Int.random(in: 0...2) // COMPUTER MAKES A CHOICE
        var computerChoice: Sign = .rock
        switch i {
        case 0: computerChoice = .rock
            signLabel.text = "✊"
        case 1: computerChoice = .paper
            signLabel.text = "✋"
        case 2: computerChoice = .scissors
            signLabel.text = "✌️"
        default :
            print("")
        }
        // Shows what the user picks
        rockButton.isHidden = true
        paperButton.isHidden = true
        scissorsButton.isHidden = true
        playAgainButton.isHidden = false
        
        if userChoice == .rock {
            rockButton.isHidden = false
        } else if userChoice == .paper {
            paperButton.isHidden = false
        } else {
            scissorsButton.isHidden = false
        }
        //Is a Draw
        if userChoice == computerChoice {
            updateUI(forState: .draw) // calls draw function
            return
        }
        //Is not a draw
        var status: GameState = .win
        switch userChoice {
        case .rock:
            if computerChoice == .paper {
                status = .lose
            } else {
                status = .win
            }
        case .paper:
            if computerChoice == .scissors {
                status = .lose
            } else {
                status = .win
            }
        case .scissors:
            if computerChoice == .rock {
                status = .lose
            } else {
                status = .win
            }
        }//End of Switch
        updateUI(forState: status)
    }
    
}

