//
//  InformationViewController.swift
//  RockPaperScissors
//
//  Created by Jesús Lugo Sáenz on 05/12/24.
//

import UIKit

class InformationViewController: UIViewController {

    private var infoTextView: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(infoTextView)
        addInfoTextView()
        infoTextView.numberOfLines = 0
        infoTextView.text = """
    🎮 How to Play Rock, Paper, Scissors

    1️⃣ Each player chooses one of three moves: 
    Rock (✊), Paper (✋), or Scissors (✌️).
    2️⃣ Both players reveal their choices at the same time.
    3️⃣ The winner is decided based on these simple rules:

    Rock (✊) beats Scissors (✌️) (it crushes them).
    Scissors (✌️) beats Paper (✋) (they cut it).
    Paper (✋) beats Rock (✊) (it wraps it).
    4️⃣ If both players choose the same move, 
       it’s a tie (🤝)—try again!

    🌟 Game Modes:

    1. Round Mode

    *Players compete over a fixed number 
     of rounds.
    *The player who wins the most rounds is 
     the champion!

    2. Points Mode

    *Players start with 0 points, and the goal is to 
     reach a target score first.
    *The user sets the following values:
        *Points Gained for Winning (🏆): How many points you earn when you win a round.
        *Points Lost for Losing (❌): How many points are subtracted if you lose.
        *Winning Score (🎯): The total points needed to win the game.
    ✨ It’s up to the player to decide their strategy and enjoy the challenge! 🎉
"""
        infoTextView.textAlignment = .left
    }
    
    private func addInfoTextView() {
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            infoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            infoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }

}
