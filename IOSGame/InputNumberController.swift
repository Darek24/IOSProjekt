//
//  InputNumberController.swift
//  IOSGame
//
//  Created by Dix on 5/17/20.
//  Copyright © 2020 Dix. All rights reserved.
//

import UIKit

protocol MyDataSendingDelegateProtocol {
    func sendDataToShowController(myData: Bool, timeElapsed: Double)
 }

class InputNumberController: UIViewController{

    var delegate: MyDataSendingDelegateProtocol?
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var inputNumberField: UITextField!


    var receivedLevel = ""
    var receivedScore = ""
    var receivedHighscore = ""
    var receivedNumber = ""
    
    let startTime = Date().timeIntervalSince1970  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        levelLabel.text = receivedLevel
        scoreLabel.text = receivedScore
        highscoreLabel.text = receivedHighscore
        inputNumberField.text = ""

    }
	
    
    @IBAction func AcceptAction(_ sender: Any) {
        if self.delegate != nil && self.inputNumberField.text != nil {
        var levelUp = false
 
        let endTime = Date().timeIntervalSince1970
        let elapsedTime = endTime - startTime
            
        if(inputNumberField.text == receivedNumber) {
                levelUp = true
            }
            self.delegate?.sendDataToShowController(myData: levelUp, timeElapsed: elapsedTime)
        dismiss(animated: true, completion: nil)
        }
    }
}
