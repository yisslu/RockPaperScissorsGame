//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Jesús Lugo Sáenz on 25/10/24.
//

import UIKit

class ConfigurationGameViewController: UIViewController {

    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var scoreNeedToWin: UITextField!{
        didSet{
            scoreNeedToWin.delegate = self
        }
    }
    @IBOutlet weak var pointsIfWin: UITextField! {
        didSet{
            pointsIfWin.delegate = self
        }
    }
    @IBOutlet weak var pointsIfLose: UITextField!{
        didSet{
            pointsIfLose.delegate = self
        }
    }
    @IBOutlet weak var sliderRounds: UISlider!
    @IBOutlet weak var stackPoitnsGame: UIStackView!
    @IBOutlet weak var stackRoundsGame: UIStackView!
    @IBOutlet weak var segmentGameMode: UISegmentedControl!
    @IBOutlet weak var labelNumberOfRounds: UILabel!
    @IBOutlet weak var button: UIButton!
    
    enum GameMode: String {
        case points = "For Points"
        case rounds = "For Rounds"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentGameMode.setTitle(GameMode.points.rawValue, forSegmentAt: 0)
        segmentGameMode.setTitle(GameMode.rounds.rawValue, forSegmentAt: 1)
        segmentGameMode.selectedSegmentIndex = 0
        stackRoundsGame.isHidden = true
        sliderRounds.minimumValue = 1
        sliderRounds.maximumValue = 5
        sliderRounds.setValue(1.5, animated: false)
        labelNumberOfRounds.text = "Número de rondas: 1"
        button.isHidden = true
    }
    
    @IBAction func selectGameMode(_ sender: UISegmentedControl) {
        let mode = sender.selectedSegmentIndex
        if mode == 1{
            stackPoitnsGame.isHidden = true
            stackRoundsGame.isHidden = false
            button.isHidden = !allFieldsAreFilled()
        }else{
            stackRoundsGame.isHidden = true
            stackPoitnsGame.isHidden = false
            
        }
    }
    
    @IBAction func selectNumberOfRounds(_ sender: UISlider){
        labelNumberOfRounds.text = "Número de rondas: \(Int(sender.value))"
        button.isHidden = !allFieldsAreFilled()
    }
    
    @IBAction func userNameGame(_ sender: UITextField){
        if segmentGameMode.selectedSegmentIndex == 1{
            button.isHidden = !allFieldsAreFilled()
        }
       
    }
    
    @IBAction func configurationValuesGame(_ sender: UITextField){
        if sender.isEditing{
            button.isHidden = !allFieldsAreFilledForPoints()
        }
    }
    
    @IBAction func infoTextButton(_ sender: Any) {
        let infoViewController = InformationViewController()
        navigationController?.present(infoViewController, animated: true)
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton){
        gameSegue()
    }
    
    private func allFieldsAreFilled() -> Bool{
        return !(userName.text!.isEmpty) && (Int(sliderRounds.value)) > 0
    }
    
    private func allFieldsAreFilledForPoints() -> Bool{
        return !scoreNeedToWin.text!.isEmpty && !pointsIfWin.text!.isEmpty && !pointsIfLose.text!.isEmpty && !userName.text!.isEmpty
    }
    
    private func gameSegue(){
        let gameViewController = GameViewController(nibName: nil, bundle: nil)
        if segmentGameMode.selectedSegmentIndex == 0{
            gameViewController.addPoints = Int(pointsIfWin.text!)!
            gameViewController.subtractionPoints = Int(pointsIfLose.text!) ?? 0
            gameViewController.pointsForWin = Int(scoreNeedToWin.text!) ?? 0
            gameViewController.isForRounds = false
            gameViewController.userName = userName.text!
        }else{
            gameViewController.isForRounds = true
            gameViewController.numberOfRounds = Int(sliderRounds.value)
            gameViewController.userName = userName.text!
        }
        
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(gameViewController, animated: true)
        
    }

}


extension ConfigurationGameViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

