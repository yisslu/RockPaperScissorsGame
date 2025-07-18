//
//  GameViewController.swift
//  RockPaperScissors
//
//  Created by Jesús Lugo Sáenz on 26/10/24.
//

import UIKit

class GameViewController: UIViewController {

    var addPoints: Int = 0
    var subtractionPoints: Int = 0
    var pointsForWin: Int = 10
    var isForRounds: Bool = false
    var numberOfRounds: Int = 10
    var userName: String = "User"
    
    @IBOutlet weak var userPointsLabel: UILabel!
    @IBOutlet weak var winPointsLabel: UILabel!
    @IBOutlet weak var computerChooseLabel: UILabel!
    @IBOutlet weak var userWinLabel: UILabel!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var score = 0{
        didSet{
            userPointsLabel.text = "Score:\(score)"
        }
    }
    
    var rounds = 0{
        didSet{
            userPointsLabel.text = "Won Rounds: \(rounds)"
        }
    }
    
    var userChooseOption: choose = .none
    
    var history: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
        if isForRounds{
            userPointsLabel.text = "Won Rounds: 0"
            winPointsLabel.text = "Total rounds: \(numberOfRounds)"
            computerChooseLabel.text = ""
            userWinLabel.text = "Welcome \(userName)"
        }else{
            userPointsLabel.text = "Score: 0"
            winPointsLabel.text = "Total pints: \(pointsForWin)"
            computerChooseLabel.text = ""
            userWinLabel.text = "Welcome \(userName)"
        }
    }
    
    @IBAction func rockButtonTapped(_ sender: Any) {
        if rounds < numberOfRounds || score < pointsForWin{
            userChooseOption = .rock
            disabledButtons(false)
            computerChooseLabel.text = chooseRandomComputerOption().rawValue
            checkWinner()
            nextButton.isHidden = false
        }
    }
    
    @IBAction func paperButtonTapped(_ sender: Any) {
        if rounds < numberOfRounds || score < pointsForWin{
            userChooseOption = .paper
            disabledButtons(false)
            computerChooseLabel.text = chooseRandomComputerOption().rawValue
            checkWinner()
            nextButton.isHidden = false
        }
    }
    
    @IBAction func scissorsButtonTapped(_ sender: Any) {
        if rounds < numberOfRounds || score < pointsForWin{
            userChooseOption = .scissors
            disabledButtons(false)
            computerChooseLabel.text = chooseRandomComputerOption().rawValue
            checkWinner()
            nextButton.isHidden = false
        }
    }
    
    func disabledButtons(_ option: Bool){
        rockButton.isEnabled = option
        paperButton.isEnabled = option
        scissorsButton.isEnabled = option
    }
    
    @IBAction func resetPressed(_ sender: UIButton){
        view.backgroundColor = .systemBackground
        if isForRounds{
            rounds = 0
            userChooseOption = .none
            userWinLabel.text = "Welcome \(userName)"
        }else{
            score = 0
            userChooseOption = .none
            computerChooseLabel.text = ""
            userWinLabel.text = "Welcome \(userName)"
        }
        nextButton.isHidden = false
        history = []
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton){
        disabledButtons(true)
        sender.isHidden = true
        if rounds == numberOfRounds || score >= pointsForWin{
            userWinLabel.text = "\(userName) you win the game!"
            disabledButtons(false)
            nextButton.isHidden = true
        }
    }
    
    @IBAction func sendHistory(){
        print(history)
        let historyView = HistoryViewController()
        historyView.historyArray = history
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(historyView, animated: true)
    }
    
    func chooseRandomComputerOption() -> choose {
        let randomNumber = Int.random(in: 0..<3)
        switch randomNumber {
        case 0:
            return .rock
        case 1:
            return .paper
        case 2:
            return .scissors
        default:
            return .none
        }
    }
    
    private func checkWinner(){
        if computerChooseLabel.text! == "🪨" && userChooseOption == .rock {
            setViewConfiguration(.systemBrown, winner: .draw)
        }else if computerChooseLabel.text! == "📄" && userChooseOption == .paper{
            setViewConfiguration(.systemBrown, winner: .draw)
        }else if computerChooseLabel.text! == "✂️" && userChooseOption == .scissors{
            setViewConfiguration(.systemBrown, winner: .draw)
        }else if computerChooseLabel.text! == "🪨" && userChooseOption == .paper{
            setViewConfiguration(.systemGreen, winner: .user)
        }else if computerChooseLabel.text! == "🪨" && userChooseOption == .scissors{
            setViewConfiguration(.systemRed, winner: .computer)
        }else if computerChooseLabel.text! == "📄" && userChooseOption == .rock{
            setViewConfiguration(.systemRed, winner: .computer)
        }else if computerChooseLabel.text! == "📄" && userChooseOption == .scissors{
            setViewConfiguration(.systemGreen, winner: .user)
        }else if computerChooseLabel.text! == "✂️" && userChooseOption == .rock{
            setViewConfiguration(.systemGreen, winner: .user)
        }else if computerChooseLabel.text! == "✂️" && userChooseOption == .paper{
            setViewConfiguration(.systemRed, winner: .computer)
        }
                    
    }
    
    private func setViewConfiguration(_ color: UIColor, winner: whoWin){
        view.backgroundColor = color
        switch isForRounds {
        case true where (rounds < numberOfRounds):
            switch winner{
            case .user:
                rounds += 1
                userWinLabel.text = "\(userName) you win!"
                history.append("\(userName) you win!")
                break
            case .computer:
                userWinLabel.text = "\(userName) you lost!"
                history.append("\(userName) you lost!")
                break
            case .draw:
                userWinLabel.text = "Draw"
                history.append("Draw")
                break
            }
        case false where (score < pointsForWin):
            switch winner {
            case .user:
                score += addPoints
                userWinLabel.text = "\(userName) you win!"
                history.append("\(userName) you win + \(addPoints)!")
                break
            case .computer where score > 0:
                score -= subtractionPoints
                userWinLabel.text = "\(userName) you lost!"
                history.append("\(userName) you lost - \(subtractionPoints)!")
                break
            case .computer:
                userWinLabel.text = "\(userName) you lost!"
                history.append("\(userName) you lost!")
                break
            case .draw:
                userWinLabel.text = "Draw"
                history.append("Draw")
                break
            }
        default:
            break
        }
    }
}


enum choose: String {
    case rock = "🪨"
    case paper = "📄"
    case scissors = "✂️"
    case none = ""
}

enum whoWin {
    case computer, user, draw
}
