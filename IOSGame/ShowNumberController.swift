//
//  ShowNumberController.swift
//  IOSGame
//
//  Created by Dix on 5/17/20.
//  Copyright © 2020 Dix. All rights reserved.
//

import UIKit



class ShowNumberController: UIViewController, MyDataSendingDelegateProtocol  {
    
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var showNumberLabel: UILabel!
    
    var level = 1;
    var score = 0;
    var highscore = 0;
    let HighscoreDefault = UserDefaults.standard
    var highscoresSavedFlag = false
    
    func levelUp(time: Double){
        level = level+1
        score =  (level * abs((60 - Int(time)))) + score
        if(score>highscore)
        {
        highscore = score
        }
    }
    
    func saveHighscore()
    {
        if(HighscoreDefault.value(forKey:"Highscore") != nil){
            highscore = HighscoreDefault.value(forKey: "Highscore") as! Int
            highscoreLabel.text = NSString(format: "Highscore: %i", highscore) as String
        }
        
    }
    
    func saveHighscores()
    {
        if(score > 0)
        {
            var array = HighscoreDefault.array(forKey: "SavedIntArray")  as? [Int] ?? [Int]()
            array.append(score)
            HighscoreDefault.set(array, forKey: "SavedIntArray")
            HighscoreDefault.synchronize()
        }
    }
    
    
    func createLevel(){
        let smallN = Int(powf(10, Float(level)+1))
        let bigN = Int(powf(10, Float(level)+2))
        let number = Int.random(in: smallN ..< bigN )
        
        levelLabel.text = NSString(format: "Level: %i", level) as String
        levelLabel.text = NSString(format: "Level: %i", level) as String
        scoreLabel.text = NSString(format: "Score: %i", score) as String
        highscoreLabel.text = NSString(format: "Highscore: %i", highscore) as String
        showNumberLabel.text = String(number)
    }
    
    func sendDataToShowController(myData: Bool, timeElapsed: Double) {
        if(myData == true)
        {
            levelUp(time: timeElapsed)
            createLevel()
            self.view.backgroundColor = UIColor.green
        }
        else
        {
            level = 1
            createLevel()
            self.view.backgroundColor = UIColor.red
            saveHighscores()
            score = 0
        }
        saveHighscore()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(HighscoreDefault.value(forKey:"Highscore") != nil){
            highscore = HighscoreDefault.value(forKey: "Highscore") as! Int
            highscoreLabel.text = NSString(format: "Highscore: %i", highscore) as String
        }
        highscoresSavedFlag = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dataToBeSent = [levelLabel.text,scoreLabel.text,highscoreLabel.text,showNumberLabel.text]
        if segue.identifier == "SendShowNumberSegue" {
            let secondVC: InputNumberController = segue.destination as! InputNumberController
            secondVC.receivedLevel = dataToBeSent[0]!
            secondVC.receivedScore = dataToBeSent[1]!
            secondVC.receivedHighscore = dataToBeSent[2]!
            secondVC.receivedNumber = dataToBeSent[3]!
            secondVC.delegate = self
        }
    }
    
    @IBAction func NextViewAction(_ sender: Any) {
        performSegue(withIdentifier: "SendShowNumberSegue", sender: self)
    }
    
    @IBAction func GoBackToMenu(_ sender: Any) {
        saveHighscores()
    }
    
    
}

